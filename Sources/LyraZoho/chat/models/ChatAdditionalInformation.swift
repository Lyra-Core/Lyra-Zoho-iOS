import Foundation

public final class ChatAdditionalInformation: NSObject {
    var companyName: String
    var primaryNeed: String
    
    public init(companyName: String, primaryNeed: String) {
        self.companyName = companyName
        self.primaryNeed = primaryNeed
    }
}
