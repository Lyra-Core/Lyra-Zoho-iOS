import Mobilisten
import Synchronization
import Foundation

final class NotificationClient {
    static let shared = Mutex<NotificationClient>(NotificationClient())
    
    func enablePush(token: String, isTestDevice: Bool) {
        do throws (InitializationError) {
            let isSDKInitialized = CoreInitializer.shared.withLock({ core in  return core.isInitialized() })
            if !isSDKInitialized {
                throw .sdkUninitialized
            }
            
            let isZohoSDKInitialized = CoreInitializer.shared.withLock({ core in  return core.isZohoInitialized() })
            if !isZohoSDKInitialized {
                throw .zohoSDKUninitialized
            }
            
            do {
                ZohoSalesIQ.enablePush(token, isTestDevice: isTestDevice, mode: .production)
            } catch {
                
                guard let exceptionHandlingCallback = CoreInitializer.shared.withLock({ core in  return core.getExceptionHandlingCallback() }) else { return }
                
                exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.NOTIFICATION_ENABLE_PUSH))
            }
            
        } catch InitializationError.sdkUninitialized {
            // TODO: Figure out what to do here
        } catch {
            
            guard let exceptionHandlingCallback = CoreInitializer.shared.withLock({ core in  return core.getExceptionHandlingCallback() }) else { return }
            
            exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.NOTIFICATION_ENABLE_PUSH))
        }
    }
    
    func handleNotification(userInfo: Optional<[AnyHashable: Any]>, response: Optional<String>, actionIdentifier: Optional<String>){
        do throws (InitializationError) {
            let isSDKInitialized = CoreInitializer.shared.withLock({ core in  return core.isInitialized() })
            if !isSDKInitialized {
                throw .sdkUninitialized
            }
            
            let isZohoSDKInitialized = CoreInitializer.shared.withLock({ core in  return core.isZohoInitialized() })
            if !isZohoSDKInitialized {
                throw .zohoSDKUninitialized
            }
            do throws (NotificationError) {
                guard let isZohoNotification = self.isZohoNotification(data: userInfo) else { throw .unknowNotificationError}
                guard let internalActionIdentifier = actionIdentifier else { throw .actionIdentifierNotProvided }
                guard let internalUserInfo = userInfo else { throw .userInfoNotProvided }
                if (isZohoNotification){
                    switch actionIdentifier {
                        case "reply":
                            ZohoSalesIQ.handleNotificationAction(internalUserInfo, response: response)
                        case "tap":
                            ZohoSalesIQ.processNotificationWithInfo(internalUserInfo)
                        default:
                            break;
                    }
                }
            } catch {
                
                guard let exceptionHandlingCallback = CoreInitializer.shared.withLock({ core in  return core.getExceptionHandlingCallback() }) else { return }
                
                exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.NOTIFICATION_ENABLE_PUSH))
            }
        } catch InitializationError.sdkUninitialized {
            // TODO: Figure out what to do here
        } catch {
            
            guard let exceptionHandlingCallback = CoreInitializer.shared.withLock({ core in  return core.getExceptionHandlingCallback() }) else { return }
            
            exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.NOTIFICATION_ENABLE_PUSH))
        }
    }
    
    func isZohoNotification(data: [AnyHashable: Any]?) -> Optional<Bool> {
        do throws (InitializationError) {
            let isSDKInitialized = CoreInitializer.shared.withLock({ core in  return core.isInitialized() })
            if !isSDKInitialized {
                throw .sdkUninitialized
            }
            
            let isZohoSDKInitialized = CoreInitializer.shared.withLock({ core in  return core.isZohoInitialized() })
            if !isZohoSDKInitialized {
                throw .zohoSDKUninitialized
            }
            do {
                return ZohoSalesIQ.isMobilistenNotification(data)
            } catch {
                
                guard let exceptionHandlingCallback = CoreInitializer.shared.withLock({ core in  return core.getExceptionHandlingCallback() }) else { return nil }
                
                exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.NOTIFICATION_ENABLE_PUSH))
                return nil
            }
        } catch InitializationError.sdkUninitialized {
            // TODO: Figure out what to do here
            return nil
        } catch {
            
            guard let exceptionHandlingCallback = CoreInitializer.shared.withLock({ core in  return core.getExceptionHandlingCallback() }) else { return nil }
            
            exceptionHandlingCallback.onException(error: ExceptionEvent(exception: error.localizedDescription, exceptionLocation: ExceptionLocation.NOTIFICATION_ENABLE_PUSH))
            
            return nil
        }
    }
    
}
