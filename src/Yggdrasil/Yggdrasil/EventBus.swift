import Foundation

/// [YGG] The GRC-compliant State Machine.
actor EventBus {
    static let shared = EventBus()
    private(set) var eventLog: [EventCode] = []
    
    private init() {}
    
    /// [YGG] Publishes and persists a new event IF it passes validation.
    func publish(_ event: EventCode) {
        if !validate(event) {
            print("[YGG] GRC VALIDATION FAILURE: Sequence violation for \(event)")
            return
        }

        eventLog.append(event)
        StorageManager.shared.save(log: eventLog)
        
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .yggEvent, object: event)
        }
    }

    /// [YGG] Cold Boot Recovery: Loads history from disk
    func loadFromDisk() {
        let savedLog = StorageManager.shared.load()
        self.eventLog = savedLog
        
        print("[YGG] Recovery: Loaded \(savedLog.count) events from disk.")
        
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .yggRecoveryComplete, object: nil)
        }
    }
    
    private func validate(_ event: EventCode) -> Bool {
        let history = eventLog
        let hasMuster = history.contains { if case .eventCreated = $0 { return true }; return false }
        let hasStarted = history.contains { if case .tournamentStarted = $0 { return true }; return false }
        let playerCount = history.filter { if case .playerRegistered = $0 { return true }; return false }.count

        switch event {
        case .appLaunched: return true
        case .eventCreated: return !hasMuster
        case .playerRegistered:
            if !hasMuster || hasStarted { return false }
            return true
        case .tournamentStarted:
            if !hasMuster || playerCount < 2 || hasStarted { return false }
            return true
        }
    }
}

// This MUST be outside the actor
extension Notification.Name {
    static let yggEvent = Notification.Name("yggEvent")
    static let yggRecoveryComplete = Notification.Name("yggRecoveryComplete")
}
