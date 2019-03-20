//
//  NotificationManager.h
//  AIQUA
//
//  Created by Shiv.Raj on 15/8/18.
//  Copyright © 2018 Appier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utility.h"

@interface NotificationManager : NSObject

+ (instancetype)sharedInstance;

- (void)initializeSDKWithAppId;
- (void)requestPushPermission;


- (void)handleDeeplinkWithURL:(NSURL *)url withNavigation:(UINavigationController *)nav;

@end
