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
        
        let cachedData: Data? = dataCache.getObject(forKey: "departments") as Data?
        guard let unwrappedCachedData = cachedData else {
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
        let cachedString = String(data: unwrappedCachedData, encoding: .utf8)
        return cachedString
        
    }
    
    func clearDepartmentCache() {
        dataCache.removeObject(forKey: "departments")
    }
}
