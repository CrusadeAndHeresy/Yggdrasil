import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        // --- START OF TABVIEW CONTAINER ---
        TabView {
            
            // Tab 1: Dashboard
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "gauge.with.needle")
                }
            
            // Tab 2: Control Panel
            // We wrap this in a NavigationView so it has a top title bar
            NavigationView {
                ControlPanelView()
            }
            .tabItem {
                Label("Controls", systemImage: "slider.horizontal.3")
            }
            
            // Tab 3: Audit Log
            AuditLogView()
                .tabItem {
                    Label("Audit", systemImage: "list.bullet.clipboard")
                }
            
        }
        // --- END OF TABVIEW CONTAINER ---
    }
}

// MARK: - Dashboard Sub-View
// We keep this in the same file for now to make it easy to manage
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

// MARK: - Preview
#Preview {
    ContentView()
        .environmentObject(AppState.shared)
}
