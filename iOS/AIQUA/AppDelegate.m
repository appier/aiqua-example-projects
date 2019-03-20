//
//  AppDelegate.m
//  AIQUA
//
//  Created by Shiv.Raj on 8/8/18.
//  Copyright © 2018 Appier. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import "QGSdk.h"
#import "Utility.h"
#import "NotificationManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // all navigation bar color and tint style
    UINavigationBar.appearance.barTintColor = [UIColor colorWithRed:77/255.0 green:78/255.0 blue:79/255.0 alpha:1];
    UINavigationBar.appearance.tintColor = [UIColor whiteColor];
    UINavigationBar.appearance.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:15]};
    
    // initialise sdk if logged in
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:AIQUA_LOGIN_STATUS]) {
        // initialise sdk
        NotificationManager *manager = [NotificationManager sharedInstance];
        [manager initializeSDKWithAppId];
        
        //request push permission
        [manager requestPushPermission];
    }
    
    return YES;
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"My token is: %@", deviceToken);
    [[QGSdk getSharedInstance] setToken:deviceToken];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error.localizedDescription);
}

//used for silent push handling
//pass completion handler UIBackgroundFetchResult accordingly
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler
{
    [[QGSdk getSharedInstance] application:application didReceiveRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNoData);
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    [[NotificationManager sharedInstance] handleDeeplinkWithURL:url withNavigation:[self getNavigationController]];
    
    return true;
}

- (UINavigationController *)getNavigationController
{
    UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
    return nav;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
