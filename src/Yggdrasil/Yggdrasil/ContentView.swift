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

// MARK: - Preview
#Preview {
    ContentView()
        .environmentObject(AppState.shared)
}
