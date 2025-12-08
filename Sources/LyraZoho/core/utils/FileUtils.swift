import Synchronization
import Foundation

@MainActor
final class FileUtils: Sendable {
    static let shared = FileUtils()
    private let dataCache = DataCache()
    
    func getFile(named: String, extensioned: String) -> String? {
        guard let url = Bundle.module.url(forResource: named, withExtension: extensioned) else { return nil }
        return try? String(contentsOf: url, encoding: .utf8)
    }
    
    func getDepartmentFile() async -> String? {
        
        if let cachedData = try? dataCache.getObject(forKey: "departments") as? Data,
           let cachedString = String(data: cachedData, encoding: .utf8)
        {
            return cachedString
        }
        
        let url: String
        if CoreInitializer.shared.getEnvironment() == .PRODUCTION {
            url = "https://icascontentstorage.blob.core.windows.net/assets/Chat/zoho-departments-Production.json"
        } else {
            url = "https://icascontentstorage.blob.core.windows.net/assets/Chat/zoho-departments-Staging.json"
        }
        
        guard let urlParsed = URL(string: url) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: urlParsed)
            
            dataCache.setObject(data, forKey: "departments")
            
            return String(data: data, encoding: .utf8)
        } catch {
            print("Network error in getDepartmentFile(): \(error)")
            return nil
        }
    }
    
    func clearDepartmentCache() {
        dataCache.removeObject(forKey: "departments")
    }
}
