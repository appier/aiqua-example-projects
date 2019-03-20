//
//  NotificationService.m
//  NotificationService
//
//  Created by qgraph on 14/09/16.
//  Copyright © 2016 QuantumGraph. All rights reserved.
//

#import "NotificationService.h"
#import "QGNotificationSdk.h"

@interface NotificationService ()

@end

static NSString *APP_GROUP = @"group.com.company.product.notification";

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    QGNotificationSdk *qgsdk = [QGNotificationSdk sharedInstanceWithAppGroup:APP_GROUP];
    
    [qgsdk didReceiveNotificationRequest:request withContentHandler:^(UNNotificationContent *content){
        contentHandler(content);
    }];
}


- (void)serviceExtensionTimeWillExpire {
    [[QGNotificationSdk sharedInstanceWithAppGroup:APP_GROUP] serviceExtensionTimeWillExpire];
}

@end
