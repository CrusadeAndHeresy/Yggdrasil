import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            // The Liquid Glass Base
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
            
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
}
