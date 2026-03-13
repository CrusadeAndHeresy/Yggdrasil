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
    
    private func processEvent(_ event: EventCode) {
        switch event {
        case .tournamentStarted(_, _):
            self.isTournamentActive = true
            self.currentRound = 1
        case .playerRegistered(_, _, _):
            self.registeredPlayers += 1
        default:
            break
        }
    }
}

