import Foundation

public final class ChatAdditionalInformation: NSObject {
    var companyName: String
    var primaryNeed: String
    
    init(companyName: String, primaryNeed: String) {
        self.companyName = companyName
        self.primaryNeed = primaryNeed
    }
}
