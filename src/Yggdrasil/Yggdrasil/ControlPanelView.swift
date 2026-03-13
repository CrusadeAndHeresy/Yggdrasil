import SwiftUI

struct ControlPanelView: View {
    // Access the state to see real-time registration counts
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        List {
            Section("Tournament Actions") {
                Button(action: {
                    Task {
                        await EventBus.shared.publish(.tournamentStarted(name: "Istvaan III", date: Date()))
                    }
                }) {
                    Label("Start Tournament", systemImage: "play.fill")
                }
                .disabled(appState.isTournamentActive)
            }
            
            Section("Player Management") {
                Button(action: {
                    Task {
                        // Simulating a player registration
                        await EventBus.shared.publish(.playerRegistered(
                            id: UUID(),
                            name: "Player \(appState.registeredPlayers + 1)",
                            faction: "Legiones Astartes"
                        ))
                    }
                }) {
                    Label("Register Random Player", systemImage: "person.badge.plus")
                }
            }
        }
        .navigationTitle("Control Panel")
    }
}

