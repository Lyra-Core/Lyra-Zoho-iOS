import Foundation

public final class Department: NSObject, Codable {
    var name: String
    var codes: [String]
    var `default`: Bool   
}
