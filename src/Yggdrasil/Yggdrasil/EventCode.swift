import Foundation

/// [YGG] The central dictionary for all actions in the Yggdrasil system.
enum EventCode: Codable, Equatable {
    
    // MARK: - App & System
    case appLaunched(timestamp: Date)
    
    // MARK: - Tournament Lifecycle
    case tournamentStarted(name: String, date: Date)
    case roundStarted(roundNumber: Int)
    case roundEnded(roundNumber: Int)
    
    // MARK: - Player & Scoring
    case playerRegistered(id: UUID, name: String, faction: String)
    case scoreSubmitted(playerId: UUID, round: Int, primaryVP: Int, secondaryVP: Int)
    
    // MARK: - GRC & Audit
    case manualCorrection(adminId: String, reason: String, previousEventId: UUID)
}

// Helper for logging
extension EventCode: CustomStringConvertible {
    var description: String {
        switch self {
        case .appLaunched: return "[YGG] System: Application Launched"
        case .roundStarted(let r): return "[YGG] Round \(r): Started"
        case .scoreSubmitted(let id, let r, let p, let s):
            return "[YGG] Score: Player \(id.uuidString.prefix(4)) submitted \(p+s) VP for Round \(r)"
        default: return "[YGG] Event: \(self)"
        }
    }
}
