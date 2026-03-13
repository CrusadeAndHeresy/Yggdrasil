import SwiftUI

struct AuditLogView: View {
    // We create a local state to hold the log entries we fetch from the actor
    @State private var logEntries: [EventCode] = []
    
    var body: some View {
        NavigationView {
            List(logEntries.reversed(), id: \.description) { event in
                VStack(alignment: .leading) {
                    Text(event.description)
                        .font(.system(.caption, design: .monospaced))
                    Text(Date().formatted()) // In Phase 3 we'll add real timestamps
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Audit Log")
            .onAppear {
                // Fetch the logs from the EventBus Actor
                Task {
                    logEntries = await EventBus.shared.getAuditLog()
                }
            }
        }
    }
}
