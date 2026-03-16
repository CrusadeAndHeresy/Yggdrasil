import SwiftUI

@main
struct YggdrasilApp: App {
    // We use the shared singleton of AppState
    @StateObject private var appState = AppState.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .onAppear {
                    // This is the trigger that wakes up the storage
                    Task {
                        await EventBus.shared.loadFromDisk()
                    }
                }
        }
    }
}
