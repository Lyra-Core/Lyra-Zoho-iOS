public final class ExceptionEvent {
    var excption: String
    var exceptionLocation: ExceptionLocation

    init(exception: String, exceptionLocation: ExceptionLocation) {
        self.excption = exception
        self.exceptionLocation = exceptionLocation
    }
}
