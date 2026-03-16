import Foundation

/// [YGG] The core vocabulary of the engine.
/// CustomStringConvertible is implemented explicitly to avoid recursion crashes.
enum EventCode: CustomStringConvertible, Codable {
    case appLaunched                          // System initialization
    case eventCreated(name: String, date: Date) // The "Muster" begins
    case playerRegistered(name: String)         // Legions signing up
    case tournamentStarted(round: Int)          // The "First Shot" is fired
    
    var description: String {
        switch self {
        case .appLaunched: return "[SYS] Yggdrasil Engine Initialized."
        case .eventCreated(let name, _): return "[MUSTER] Event '\(name)' created."
        case .playerRegistered(let name): return "[REG] \(name) has joined the muster."
        case .tournamentStarted(let round): return "[START] Round \(round) is live."
        }
    }
}


