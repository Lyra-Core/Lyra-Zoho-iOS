import Synchronization
import Foundation

final class FileUtils {
    static let shared = Mutex<FileUtils>(FileUtils())
    
    func getFile(named: String, extensioned: String) -> String? {
        guard let url = Bundle.module.url(forResource: named, withExtension: extensioned) else { return nil }
        return try? String(contentsOf: url, encoding: .utf8)
    }
}
