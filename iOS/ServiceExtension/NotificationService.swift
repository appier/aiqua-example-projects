//
//  NotificationService.swift
//  TestServiceExtension
//
//  Created by qgraph on 27/09/16.
//  Copyright © 2016 QuantumGraph. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    let APP_GROUP = "APP_GROUP"

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        
        let qgsdk = QGNotificationSdk.sharedInstance(withAppGroup: APP_GROUP)
        
        qgsdk.didReceive(request, withContentHandler: { content in
            contentHandler(content)
            })
    }
    
    override func serviceExtensionTimeWillExpire() {
        QGNotificationSdk.sharedInstance(withAppGroup: APP_GROUP).serviceExtensionTimeWillExpire()
    }

}
