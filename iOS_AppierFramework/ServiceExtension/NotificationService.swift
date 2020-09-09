//
//  NotificationService.swift
//  ServiceExtension
//
//  Created by chunta on 2020/9/9.
//  Copyright © 2020 chunta. All rights reserved.
//

import UserNotifications
import Appier
class NotificationService: QGNotificationService {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        super.didReceive(request, withContentHandler: contentHandler)
    }
    
    override func serviceExtensionTimeWillExpire() {
        super.serviceExtensionTimeWillExpire()
    }

}
