import Foundation

/// [YGG] The central dispatcher for all system events.
/// Implemented as an Actor to ensure thread-safe, GRC-compliant state management.
actor EventBus {
    
    // The shared, single instance of the bus.
    static let shared = EventBus()
    
    // A log of all events for audit purposes.
    private(set) var eventLog: [EventCode] = []
    
    // Prevent external initialization to enforce the single-binary architecture.
    private init() {}
    
    /// Publishes an event to the system and records it in the audit log.
    func publish(_ event: EventCode) {
        // 1. Log the event for GRC/Auditing
        eventLog.append(event)
        
        // 2. Print to console for debugging with the [YGG] tag
        print(event.description)
        
        // Future Phase: Here is where we will alert the UI that state has changed.
    }
    
    /// Retrieves the full audit log of events.
    func getAuditLog() -> [EventCode] {
        return eventLog
    }
}

