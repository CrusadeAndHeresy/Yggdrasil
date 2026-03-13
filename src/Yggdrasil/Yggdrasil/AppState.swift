import Foundation
import SwiftUI

/// [YGG] The Single Source of Truth for the Yggdrasil UI.
/// Locked to the MainActor to ensure the screen only updates on the main thread.
@MainActor
class AppState: ObservableObject {
    
    // MARK: - Tournament Data
    @Published var isTournamentActive: Bool = false
    @Published var currentRound: Int = 0
    @Published var registeredPlayers: Int = 0
    
    // Enforce single-binary architecture by creating exactly one instance.
    static let shared = AppState()
    
    private init() {
        print("[YGG] AppState Initialized: Single Source of Truth active.")
    }
    
    // Future Phase: We will add functions here to listen to the EventBus
    // and mutate these variables based on the EventCodes it receives.
}
