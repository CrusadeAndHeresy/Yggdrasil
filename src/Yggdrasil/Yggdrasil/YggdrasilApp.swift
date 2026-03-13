import SwiftUI

@main
struct YggdrasilApp: App {
    // [YGG] Initialize the Single Source of Truth for the entire app UI.
    @StateObject private var appState = AppState.shared
    
    init() {
        // [YGG] Fire the very first event into the system to prove the bus is alive.
        // We use a Task because the EventBus is an Actor (GRC thread-safety).
        Task {
            await EventBus.shared.publish(.appLaunched(timestamp: Date()))
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                // [YGG] Inject the state so every UI screen can read it automatically.
                .environmentObject(appState)
        }
    }
}
