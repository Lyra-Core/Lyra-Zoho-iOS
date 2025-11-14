public final class ExceptionEvent {
    var exception: String
    var exceptionLocation: ExceptionLocation

    init(exception: String, exceptionLocation: ExceptionLocation) {
        self.exception = exception
        self.exceptionLocation = exceptionLocation
    }
}
