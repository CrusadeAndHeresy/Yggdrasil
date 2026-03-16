import Foundation

/// [YGG] The GRC-compliant State Machine.
/// Every event is validated against history before being persisted or processed.
actor EventBus {
    static let shared = EventBus()
    
    // The source of truth for all campaign actions
    private(set) var eventLog: [EventCode] = []
    
    private init() {}
    
    /// [YGG] Publishes and persists a new event IF it passes validation.
    func publish(_ event: EventCode) {
        
        // 1. GATEKEEPER: Validate against historical sequence
        if !validate(event) {
            print("[YGG] GRC VALIDATION FAILURE: Sequence violation for \(event)")
            return // KILL: Event is rejected and never reaches the log
        }

        // 2. PERSISTENCE: Append to log and write to disk
        eventLog.append(event)
        StorageManager.shared.save(log: eventLog)
        
        // 3. BROADCAST: Notify the UI (AppState)
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .yggEvent, object: event)
        }
    }
    
    /// [YGG] The Rules Engine.
    /// Enforces the Muster -> Registration -> War sequence.
    private func validate(_ event: EventCode) -> Bool {
        let history = eventLog
        
        // Audit variables for current state
        let hasMuster = history.contains { if case .eventCreated = $0 { return true }; return false }
        let hasStarted = history.contains { if case .tournamentStarted = $0 { return true }; return false }
        let playerCount = history.filter { if case .playerRegistered = $0 { return true }; return false }.count

        switch event {
        case .appLaunched:
            return true // Always allow system boot
            
        case .eventCreated:
            // RULE: Only one Muster (event container) can be created per log.
            return !hasMuster
            
        case .playerRegistered:
            // RULE: Muster must exist; Registration must not be closed (Started).
            if !hasMuster {
                print("[YGG] ERROR: No Muster exists. Create Muster first.")
                return false
            }
            if hasStarted {
                print("[YGG] ERROR: Tournament already started. Registration closed.")
                return false
            }
            return true
            
        case .tournamentStarted:
            // RULE: Muster must exist; Must have at least 2 players; Cannot start twice.
            if !hasMuster {
                print("[YGG] ERROR: No Muster exists. Create Muster first.")
                return false
            }
            if playerCount < 2 {
                print("[YGG] ERROR: Insufficient players (\(playerCount)). Need at least 2.")
                return false
            }
            if hasStarted {
                print("[YGG] ERROR: Tournament is already live.")
                return false
            }
            return true
        }
    }

}

// This must be outside the actor's curly braces
extension Notification.Name {
    static let yggEvent = Notification.Name("yggEvent")
}
