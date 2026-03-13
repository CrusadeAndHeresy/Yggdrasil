import SwiftUI

struct ContentView: View {
    // [YGG] Reading from the Single Source of Truth injected by YggdrasilApp
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "shield.fill")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .font(.system(size: 60))
            
            Text("YGGDRASIL")
                .font(.largeTitle)
                .fontWeight(.black)
            
            Text("Tournament Engine Status:")
                .font(.headline)
                .padding(.top, 30)
            
            // [YGG] Displaying real-time state dynamically
            if appState.isTournamentActive {
                Text("Status: ACTIVE")
                    .foregroundColor(.green)
                    .bold()
                Text("Current Round: \(appState.currentRound)")
                Text("Registered Players: \(appState.registeredPlayers)")
            } else {
                Text("Status: STANDBY")
                    .foregroundColor(.gray)
                    .bold()
            }
        }
        .padding()
    }
}

// [YGG] This allows the Xcode Canvas to preview the UI without crashing
#Preview {
    ContentView()
        .environmentObject(AppState.shared)
}
