enum NotificationError: Error {
    case unknowNotificationError
    case actionIdentifierNotProvided
    case userInfoNotProvided
}

extension NotificationError : CustomStringConvertible {
    public var description: String {
        switch self {
            case .unknowNotificationError:
                return "Unknown Notification Error"
        case .actionIdentifierNotProvided:
            return "Action Identifier Not Provided"
        case .userInfoNotProvided:
            return "User Info Not Provided"
        }
    }
}
