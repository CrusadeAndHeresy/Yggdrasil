import SwiftUI

struct ControlPanelView: View {
    var body: some View {
        List {
            Section(header: Text("Tournament Phase 1: The Muster")) {
                Button(action: {
                    // [YGG] Rule: Create the event container first
                    Task {
                        await EventBus.shared.publish(.eventCreated(name: "Istvaan III Campaign", date: Date()))
                    }
                }) {
                    Label("Create Muster", systemImage: "plus.app.fill")
                }
            }
            
            Section(header: Text("Tournament Phase 2: Registration")) {
                Button(action: {
                    // [YGG] Rule: Register players to the created muster
                    Task {
                        await EventBus.shared.publish(.playerRegistered(name: "Legionary \(Int.random(in: 100...999))"))
                    }
                }) {
                    Label("Register Random Player", systemImage: "person.badge.plus")
                }
            }
            
            Section(header: Text("Tournament Phase 3: War")) {
                Button(action: {
                    // [YGG] Rule: Start the games (Round 1)
                    Task {
                        await EventBus.shared.publish(.tournamentStarted(round: 1))
                    }
                }) {
                    Label("Start Round 1", systemImage: "play.fill")
                        .foregroundColor(.green)
                }
            }
        }
        .navigationTitle("Control Panel")
    }
}
