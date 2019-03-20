//
//  Utility.h
//  AIQUA
//
//  Created by Shiv.Raj on 9/8/18.
//  Copyright © 2018 Appier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define Color(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define BUTTON_COLOR Color(36, 172, 255, 0.1)
#define BUTTON_BORDER_COLOR Color(36, 172, 255, 0.7)
#define BUTTON_COLOR_OPAQUE Color(36, 172, 255, 1)

#define BACKGROUND_COLOR Color(38, 40, 43, 1)

#define BLACK_OPACITY_20 Color(0, 0, 0, 0.2)
#define WHITE_OPACITY_20 Color(255, 255, 255, 0.2)
#define WHITE_OPACITY_5 Color(255, 255, 255, 0.05)

#define CLEAR_COLOR Color(0, 0, 0, 0)

#define CATEGORY_VIEWED_STATUS      @"category_viewed_status"
#define LAST_VIEWED_CATEGORY_IMAGE  @"last_viewed_category_image"
#define LAST_VIEWED_CATEGORY_TITLE  @"last_viewed_category_title"
#define LAST_VIEWED_CATEGORY_NAME   @"last_viewed_category_name"

#define AIQUA_LOGIN_STATUS          @"aiqua_login_status"
#define NAME                        @"name"
#define WORK_EMAIL                  @"work_email"
#define EMAIL                       @"email"
#define COMPANY                     @"company"

// AIQUA DEFAULT EVENT NAMES
#define CONTACTED_SALES             @"contacted_sales"
#define PAGE_VIEWED                 @"page_viewed"
#define CATEGORY_VIEWED             @"category_viewed"
#define PRODUCT_VIEWED              @"product_viewed"
#define PUSH_TRIGGERED              @"local_notification_triggered"
#define INAPP_TRIGGERED             @"inapp_triggered"
#define CLICKED_PERSONALIZED_NOTIF  @"clicked_personalizedNotification"
#define ADDED_TO_WISHLIST           @"product_added_to_wishlist"
#define ADDED_TO_CART               @"product_added_to_cart"

// EVENT PARAMETERS
#define TEMPLATE_LISTING            @"templateListing"
#define PAGE_NAME                   @"page_name"
#define NOTIFICATION_TEMPLATE       @"notification_template"
#define INAPP_TEMPLATE              @"inapp_template"
#define CATEGORY_NAME               @"category_name"
#define CATEGORY_DEEPLINK           @"category_deeplink"

#define PRODUCT_NAME                @"product_name"
#define PRODUCT_PRICE               @"product_price"
#define PRODUCT_RATING              @"product_rating"
#define PRODUCT_CATEGORY            @"product_category"
#define PRODUCT_IMAGE_URL           @"product_image_url"
#define PRODUCT_DEEPLINK            @"product_deeplink"

// PUSH NOTIFICATION TYPES
#define PUSH_IMAGE                  @"IMAGE"
#define PUSH_CAROUSEL               @"CAROUSEL"
#define PUSH_SLIDER                 @"SLIDER"
#define PUSH_GIF                    @"GIF"
#define PUSH_VIDEO                  @"VIDEO"

// INAPP TYPES
#define INAPP_FLOATING              @"FLOATING"
#define INAPP_SMALL                 @"SMALL"
#define INAPP_MEDIUM                @"MEDIUM"
#define INAPP_FULL_SCREEN           @"FULL SCREEN"

#define SELECTED_COUNTRY_INDEX      @"selected_country_index"

#define APP_GROUP                   @"group.com.company.product.notification"

typedef enum Type : NSUInteger {
    kTypePushCarousel = 0,
    kTypePushGIF = 1,
    kTypePushVideo = 2,
    kTypePushImage = 3,
    kTypePushSlider = 4,
    
    kTypeInAppFloating = 10,
    kTypeInAppSmall = 11,
    kTypeInAppMedium = 12,
    kTypeInAppLarge = 13
} Type;

@interface Utility : NSObject

+ (instancetype)sharedInstance;
+ (NSArray *)country;

+ (NSArray *)category;
+ (NSDictionary *)products;

@end
