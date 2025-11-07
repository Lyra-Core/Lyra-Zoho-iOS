import Synchronization

@MainActor
public final class LyraZoho: Sendable {
    public static let shared = Mutex<LyraZoho>(LyraZoho())
    
    private init() {
        
    }
    
    public func initialize(config: LyraConfig, zohoConfig: ZohoConfig) {
        let coreInitializer = CoreInitializer.shared.withLock({ core in return core })
        
        coreInitializer.initialize(config: config)
        coreInitializer.initializeZoho(zohoConfig: zohoConfig)
    }
    
    public func isInialized() -> Bool {
        let coreInitializer = CoreInitializer.shared.withLock({ core in return core })
        
        return coreInitializer.isInitialized()
    }
    
    public func isZohoInialized() -> Bool {
        let coreInitializer = CoreInitializer.shared.withLock({ core in return core })
        
        return coreInitializer.isZohoInitialized()
    }
    
    public func getApiKey() -> Optional<String> {
        let coreInitializer = CoreInitializer.shared.withLock({ core in return core })
        
        return coreInitializer.getApiKey()
    }
    
    public func getConfig() -> Optional<LyraConfig> {
        let coreInitializer = CoreInitializer.shared.withLock({ core in return core })
        
        return coreInitializer.getConfig()
    }
    
    // Chat functionality = properly exposed
    public func startChatListeners(listener: Optional<ZohoChatListener>)  throws (InitializationError) {
        let chatClient = ChatClient.shared.withLock({ chat in return chat })
        try chatClient.startLissteners(listener: listener)
    }
    
    public func openChat(listener: Optional<ZohoChatListener>)  throws (InitializationError) {
        let chatClient = ChatClient.shared.withLock({ chat in return chat })
        try chatClient.open()
    }
    
    public func setChatDepartment(countryCode: String)  throws (InitializationError) {
        let chatClient = ChatClient.shared.withLock({ chat in return chat })
        try chatClient.setDepartment(countryCode: countryCode)
    }
    
    public func setChatLanguage(languageCode: String)  throws (InitializationError) {
        let chatClient = ChatClient.shared.withLock({ chat in return chat })
        try chatClient.setLanguage(languageCode: languageCode)
    }
    
    public func setChatQuestion()  throws (InitializationError) {
        let chatClient = ChatClient.shared.withLock({ chat in return chat })
        try chatClient.setQuestion()
    }
    
    public func setPageTitle(title: String)  throws (InitializationError) {
        let chatClient = ChatClient.shared.withLock({ chat in return chat })
        try chatClient.setPageTitle(title: title)
    }
    
    public func setAdditialInforation(additionalInfo: ChatAdditionalInformation)  throws (InitializationError) {
        let chatClient = ChatClient.shared.withLock({ chat in return chat })
        try chatClient.setAdditionalInformation(additionalInfo: additionalInfo)
    }
    
    public func endChatSession() {
        let chatClient = ChatClient.shared.withLock({ chat in return chat })
        chatClient.endSession()
    }
    
    // Notification Functionality
    public func enablePushNotification(token: String, isTestDevice: Bool) {
        let notificationClient = NotificationClient.shared.withLock({ notification in return notification })
        notificationClient.enablePush(token: token, isTestDevice: isTestDevice)
    }
    
    public func handlePushNotification(data: Optional<[AnyHashable: Any]>, response: Optional<String>, actionIdentifier: Optional<String>) {
        let notificationClient = NotificationClient.shared.withLock({ notification in return notification })
        notificationClient.handleNotification(userInfo: data, response: response, actionIdentifier: actionIdentifier)
    }
    
    public func isZohoPushNotification(data: Optional<[AnyHashable: Any]>) -> Bool{
        let notificationClient = NotificationClient.shared.withLock({ notification in return notification })
        guard let response = notificationClient.isZohoNotification(data: data) else { return false }
        return response
    }
    
    // Department Functionality
    public func getAllDepartments() -> [Department] {
        let departmentClient = DepartmentClient.shared.withLock({ department in return department })
        return departmentClient.getAllDepartments()
    }
    
    public func getDefaultDepartment() -> Optional<Department> {
        let departmentClient = DepartmentClient.shared.withLock({ department in return department })
        return departmentClient.getDefaultDepartment()
    }
    
    public func getDepartmentsByCountryCode(countryCode: String) -> Optional<Department> {
        let departmentClient = DepartmentClient.shared.withLock({ department in return department })
        return departmentClient.getDepartmentsByCountry(countryCode: countryCode )
    }
    
}
