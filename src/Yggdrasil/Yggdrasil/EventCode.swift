import Foundation

/// [YGG] The core vocabulary of the engine.
/// CustomStringConvertible is implemented explicitly to avoid recursion crashes.
enum EventCode: CustomStringConvertible, Codable {
    case appLaunched(timestamp: Date)
    case tournamentStarted(name: String, date: Date)
    case playerRegistered(id: UUID, name: String, faction: String)
    case roundStarted(number: Int)
    case matchResultRecorded(matchId: UUID, winnerId: UUID)

    var description: String {
        switch self {
        case .appLaunched(let date):
            return "[YGG] App Launched at \(date)"
        case .tournamentStarted(let name, let date):
            return "[YGG] Tournament '\(name)' started on \(date)"
        case .playerRegistered(_, let name, let faction):
            return "[YGG] Player Registered: \(name) (\(faction))"
        case .roundStarted(let number):
            return "[YGG] Round \(number) Started"
        case .matchResultRecorded(let matchId, _):
            return "[YGG] Match Result Recorded for ID: \(matchId)"
        }
    }
}


