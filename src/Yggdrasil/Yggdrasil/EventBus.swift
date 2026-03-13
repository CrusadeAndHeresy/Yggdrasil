import Foundation

// [YGG] The internal radio frequency for system-wide events.
extension Notification.Name {
    static let yggEvent = Notification.Name("yggEvent")
}

/// [YGG] Central dispatcher. Actor-based to ensure GRC-compliant thread safety.
actor EventBus {
    static let shared = EventBus()
    private(set) var eventLog: [EventCode] = []
    
    private init() {}
    
    func publish(_ event: EventCode) {
        eventLog.append(event)
        print(event.description)
        
        // [YGG] Broadcast the event to the UI safely on the main thread
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .yggEvent, object: event)
        }
    }
    
    func getAuditLog() -> [EventCode] {
        return eventLog
    }
}

