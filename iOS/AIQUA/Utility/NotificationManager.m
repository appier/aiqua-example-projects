//
//  NotificationManager.m
//  AIQUA
//
//  Created by Shiv.Raj on 15/8/18.
//  Copyright © 2018 Appier. All rights reserved.
//

#import "NotificationManager.h"
#import <UserNotifications/UserNotifications.h>
#import "QGSdk.h"
#import "Category.h"
#import "Product.h"

#import "ProductDetailViewController.h"
#import "CategoryCollectionViewController.h"
#import "DemoEcomViewController.h"
#import "DemoSplashViewController.h"
#import "HomeViewController.h"


@interface NotificationManager () <UNUserNotificationCenterDelegate>

@end

@implementation NotificationManager

static NotificationManager *sharedInstance = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NotificationManager alloc] init];
    });
    return sharedInstance;
}

//----------------------------------------------
#pragma mark - Push Permission & SDK Initialise
//----------------------------------------------

- (void)initializeSDKWithAppId {
    QGSdk *qgsdk = [QGSdk getSharedInstance];
#ifdef DEBUG
    [qgsdk onStart:@"<your appid>" withAppGroup:APP_GROUP setDevProfile:true];
#else
    [qgsdk onStart:@"<your appid>" withAppGroup:APP_GROUP setDevProfile:false];
#endif
}

- (void)requestPushPermission {
    
    if (@available(iOS 10.0, *)) {
        UNAuthorizationOptions options = (UNAuthorizationOptions) (UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionCarPlay);
//        if (@available(iOS 12.0, *)) {
//            if (![qgsdk getShowPushPrompt]) {
//                //add provisional for silent push in notification center without push prompt
//                options = options | UNAuthorizationOptionProvisional;
//            }
//        }
        
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        
        [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError *error){
            NSLog(@"GRANTED: %i, Error: %@", granted, error);
        }];
    } else {
        // Fallback on earlier versions - iOS 8 & 9
        UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeSound |
        UIUserNotificationTypeBadge;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
}

//------------------------------------------
#pragma mark - UNNotificationCenterDelegate
//------------------------------------------

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler  API_AVAILABLE(ios(10.0)){
    [[QGSdk getSharedInstance] userNotificationCenter:center willPresentNotification:notification];
    UNNotificationPresentationOptions option = UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert;
    
    completionHandler(option);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    [[QGSdk getSharedInstance] userNotificationCenter:center didReceiveNotificationResponse:response];
    
    completionHandler();
}



//-------------------------------
#pragma mark - Handle DeepLink
//-------------------------------

- (void)handleDeeplinkWithURL:(NSURL *)url withNavigation:(UINavigationController *)nav {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    if ([url.host isEqualToString:@"products"]) {
        NSString *product_id = url.lastPathComponent;
        NSString *category_id = url.pathComponents[1];
        
        Category *category = [self getCategoryWithId:category_id];
        if (!category) {
            return;
        }
        CategoryCollectionViewController *cvc = [storyboard instantiateViewControllerWithIdentifier:@"CategoryVC"];
        cvc.title = category.name;
        cvc.category = category;
        cvc.categoryProducts = [Utility products][category._id];
        
        Product *product = [self getProductWithId:product_id withCategory:category_id];
        if (!product) {
            return;
        }
        ProductDetailViewController *pvc = [[ProductDetailViewController alloc] initWithNibName:@"ProductDetailViewController" bundle:nil];
        pvc.product = product;
        
        [self pushToViewWithNav:nav withViews:@[cvc, pvc]];
    } else if ([url.host isEqualToString:@"category"]) {
        Category *category = [self getCategoryWithId:url.lastPathComponent];
        if (!category) {
            return;
        }
        CategoryCollectionViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CategoryVC"];
        vc.title = category.name;
        vc.category = category;
        vc.categoryProducts = [Utility products][category._id];
        
        [self pushToViewWithNav:nav withViews:@[vc]];
    }
}

- (void)pushToViewWithNav:(UINavigationController *)nav withViews:(NSArray <UIViewController *> *)views {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    HomeViewController *home = [storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    DemoSplashViewController *demoSplash = [storyboard instantiateViewControllerWithIdentifier:@"DemoSplash"];
    DemoEcomViewController *demoEcom = [storyboard instantiateViewControllerWithIdentifier:@"DemoEcomVC"];
    
    [nav setNavigationBarHidden:NO animated:NO];
    nav.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [nav setViewControllers:[@[home, demoSplash, demoEcom] arrayByAddingObjectsFromArray:views] animated:YES];
}

- (Product *)getProductWithId:(NSString *)_id withCategory:(NSString *)category_id {
    NSArray *products = [Utility products][category_id];
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"_id == %d", _id.integerValue];
    NSArray *filteredData = [products filteredArrayUsingPredicate:filter];
    if (filteredData.count == 0) {
        return nil;
    }
    Product *product = [[Product alloc] initWithJSONData:filteredData[0]];
    
    return product;
}

- (Category *)getCategoryWithId:(NSString *)_id {
    NSArray *categories = [Utility category];
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"_id == %@", _id];
    NSArray *filteredData = [categories filteredArrayUsingPredicate:filter];
    if (filteredData.count == 0) {
        return nil;
    }
    Category *category = [[Category alloc] initWithJSONData:filteredData[0]];
    
    // mark last viewed category
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:CATEGORY_VIEWED_STATUS]) {
        [defaults setBool:true forKey:CATEGORY_VIEWED_STATUS];
    }
    [defaults setValue:category.image forKey:LAST_VIEWED_CATEGORY_IMAGE];
    [defaults setValue:category.title forKey:LAST_VIEWED_CATEGORY_TITLE];
    [defaults setValue:category.name forKey:LAST_VIEWED_CATEGORY_NAME];
    
    return category;
}

@end
