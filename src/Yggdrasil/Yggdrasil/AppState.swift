import Foundation
import SwiftUI

/// [YGG] Single Source of Truth for the UI.
/// MainActor-isolated to ensure all UI updates happen on the main thread.
@MainActor
class AppState: ObservableObject {
    @Published var isTournamentActive: Bool = false
    @Published var currentRound: Int = 0
    @Published var registeredPlayers: Int = 0
    
    static let shared = AppState()
    
    private init() {
        // [YGG] Listen for engine broadcasts
        NotificationCenter.default.addObserver(
            forName: .yggEvent,
            object: nil,
            queue: .main
        ) { notification in
            // Swift 6 fix: Jump back onto the MainActor explicitly
            Task { @MainActor in
                if let event = notification.object as? EventCode {
                    AppState.shared.processEvent(event)
                }
            }
        }
    }
    
    func processEvent(_ event: EventCode) {
        switch event {
        case .appLaunched:
            print("[YGG] System Boot Confirmed.")
            
        case .eventCreated(let name, let date):
            // For now, we just log the creation
            print("[YGG] Muster Created: \(name) on \(date)")
            
        case .playerRegistered:
            registeredPlayers += 1
            
        case .tournamentStarted:
            isTournamentActive = true
            currentRound = 1
        }
    }
}

