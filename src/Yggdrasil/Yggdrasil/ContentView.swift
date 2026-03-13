import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        TabView {
            // Tab 1: The Dashboard (Live Status)
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "gauge.with.needle")
                }
            
            // Tab 2: The Controls (Inputs)
            NavigationView {
                ControlPanelView()
            }
            .tabItem {
                Label("Controls", systemImage: "slider.horizontal.3")
            }
        }
    }
}

/// [YGG] We moved the old Dashboard UI here to keep ContentView clean
struct DashboardView: View {
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

#Preview {
    ContentView()
        .environmentObject(AppState.shared)
}
