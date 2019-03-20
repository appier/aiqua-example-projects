//
//  NotificationViewController.m
//  CustomNotificationContent
//
//  Created by qgraph on 14/09/16.
//  Copyright © 2016 QuantumGraph. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>
#import "QGNotificationSdk.h"

@interface NotificationViewController () <UNNotificationContentExtension, iCarouselDelegate, iCarouselDataSource>

@property (nonatomic, weak) IBOutlet iCarousel *carousel;

@end

static NSString *APP_GROUP = @"group.com.company.product.notification";

@implementation NotificationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //configure your action button titles
    // for ios 12 only open app button is shown, however for ios 11 and below, open app and next button both are shown.
    // for ios 12 user can also scroll carousel/slider using interaction
    [[QGNotificationSdk sharedInstanceWithAppGroup:APP_GROUP] viewDidLoadWithCarousel:_carousel withActionNextTitle:nil withActionOpenAppTitle:nil];
}

- (void)didReceiveNotification:(UNNotification *)notification
{
    [[QGNotificationSdk sharedInstanceWithAppGroup:APP_GROUP] didReceiveNotification:notification];
}

- (void)didReceiveNotificationResponse:(UNNotificationResponse *)response completionHandler:(void (^)(UNNotificationContentExtensionResponseOption))completion
{
    QGNotificationSdk *qgsdk = [QGNotificationSdk sharedInstanceWithAppGroup:APP_GROUP];
    [qgsdk didReceiveNotificationResponse:response withContext:(NSExtensionContext *)self.extensionContext completionHandler:completion];
}

///--------------------------------
#pragma mark - iCarousel Delegate
///--------------------------------

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [[QGNotificationSdk sharedInstanceWithAppGroup:APP_GROUP] numberOfItemsInCarousel:carousel];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    return [[QGNotificationSdk sharedInstanceWithAppGroup:APP_GROUP] carousel:carousel viewForItemAtIndex:index reusingView:view];
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    return [[QGNotificationSdk sharedInstanceWithAppGroup:APP_GROUP] carousel:carousel valueForOption:option withDefault:value];
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel {
    return [[QGNotificationSdk sharedInstanceWithAppGroup:APP_GROUP] carouselItemWidth:carousel];
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    if (@available(iOS 12.0, *)) {
        [[QGNotificationSdk sharedInstanceWithAppGroup:APP_GROUP] carousel:carousel didSelectItemAtIndex:index withExtensionContext:self.extensionContext];
    } else {
        // Fallback on earlier versions
    }
}

- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate {
    if (@available(iOS 12.0, *)) {
        [[QGNotificationSdk sharedInstanceWithAppGroup:APP_GROUP] carouselDidEndDragging:carousel willDecelerate:decelerate];
    }
}

- (void)dealloc
{
    self.carousel.delegate = nil;
    self.carousel.dataSource = nil;
}

@end
