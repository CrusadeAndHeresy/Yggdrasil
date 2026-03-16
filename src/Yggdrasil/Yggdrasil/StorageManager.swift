import Foundation

/// [YGG] Handles GRC-compliant data persistence.
/// Ensures the event log is written to the local file system.
class StorageManager {
    static let shared = StorageManager()
    private let fileName = "ygg_audit_log.json"
    
    // Locate the user's Document directory on the Mac/iPhone
    private var filePath: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent(fileName)
    }
    
    /// [YGG] Saves the entire log to disk.
    /// RULE: This overwrites the file with the CURRENT log,
    /// but since the EventBus only appends, no data is ever lost.
    func save(log: [EventCode]) {
        do {
            let data = try JSONEncoder().encode(log)
            try data.write(to: filePath, options: [.atomic, .completeFileProtection])
            print("[YGG] Audit Log Persisted to: \(filePath.lastPathComponent)")
        } catch {
            print("[YGG] GRC Persistence Error: \(error.localizedDescription)")
        }
    }
    
    /// [YGG] Loads the log from disk for Cold Boot Recovery
    func load() -> [EventCode] {
        guard FileManager.default.fileExists(atPath: filePath.path) else { return [] }
        do {
            let data = try Data(contentsOf: filePath)
            return try JSONDecoder().decode([EventCode].self, from: data)
        } catch {
            print("[YGG] Recovery Error: \(error.localizedDescription)")
            return []
        }
    }
}
