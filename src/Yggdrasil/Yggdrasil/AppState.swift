import Foundation
import SwiftUI

/// [YGG] Single Source of Truth for the UI.
@MainActor
class AppState: ObservableObject {
    @Published var isTournamentActive: Bool = false
    @Published var currentRound: Int = 0
    @Published var registeredPlayers: Int = 0
    
    static let shared = AppState()
    
    private init() {
        // 1. Listen for SINGLE new events
        NotificationCenter.default.addObserver(
            forName: .yggEvent,
            object: nil,
            queue: .main
        ) { notification in
            Task { @MainActor in
                if let event = notification.object as? EventCode {
                    self.processEvent(event)
                }
            }
        }
        
        // 2. Listen for FULL LOG recovery (Cold Boot)
        NotificationCenter.default.addObserver(
            forName: .yggRecoveryComplete,
            object: nil,
            queue: .main
        ) { _ in
            Task { @MainActor in
                let history = await EventBus.shared.eventLog
                self.rebuildState(from: history)
            }
        }
    }
    
    /// [YGG] Resets and replays history to restore state
    func rebuildState(from history: [EventCode]) {
        self.registeredPlayers = 0
        self.isTournamentActive = false
        self.currentRound = 0
        
        for event in history {
            self.processEvent(event)
        }
        print("[YGG] State Rebuilt: \(history.count) events processed.")
    }
    
    func processEvent(_ event: EventCode) {
        switch event {
        case .appLaunched:
            print("[YGG] System Boot Confirmed.")
            
        case .eventCreated(let name, let date):
            print("[YGG] Muster Created: \(name) on \(date)")
            
        case .playerRegistered:
            registeredPlayers += 1
            
        case .tournamentStarted:
            isTournamentActive = true
            currentRound = 1
        }
    }
}
