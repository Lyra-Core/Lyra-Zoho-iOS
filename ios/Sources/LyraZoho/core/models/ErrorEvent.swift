public final class ErrorEvent {
    public var errorCode: Int
    public var errorMessage: String
    public var errorLocation: ErrorLocation

    init(errorCode: Int, errorMessage: String, errorLocation: ErrorLocation) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
        self.errorLocation = errorLocation
    }
}
