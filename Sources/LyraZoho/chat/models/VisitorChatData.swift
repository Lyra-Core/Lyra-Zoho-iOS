
public final class VisitorChatData {
    var chatId: String
    var question: Optional<String>
    var attenderName: Optional<String>
    var attenderEmail: Optional<String>
    var attenderId: Optional<String>
    var isBotAttender: Bool
    var departmentName: Optional<String>
    var chatStatus: Optional<String>
    var unreadCount: Int
    var feedback: Optional<String>
    var rating: Optional<String>
    var lastMessage: Optional<String>
    var queuePosition: Int
    
    init(chatId: String, question: Optional<String>, attenderName: Optional<String>, attenderEmail: Optional<String>, attenderId: Optional<String>, isBotAttender: Bool, departmentName: Optional<String>, chatStatus: Optional<String>, unreadCount: Int, feedback: Optional<String>, rating: Optional<String>, lastMessage: Optional<String>, queuePosition: Int) {
        self.chatId = chatId
        self.question = question
        self.attenderName = attenderName
        self.attenderEmail = attenderEmail
        self.attenderId = attenderId
        self.isBotAttender = isBotAttender
        self.departmentName = departmentName
        self.chatStatus = chatStatus
        self.unreadCount = unreadCount
        self.feedback = feedback
        self.rating = rating
        self.lastMessage = lastMessage
        self.queuePosition = queuePosition
    }
}
