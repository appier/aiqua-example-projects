//
//  AppDelegate.swift
//  AppierSampleApp
//
//  Created by Appier on 2020/2/18.
//  Copyright © 2020 appier. All rights reserved.
//

import UIKit
import UserNotifications

fileprivate let appId:String = "APP_ID"
fileprivate let appGroup:String = "APP_GROUP"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch
        let QG = QGSdk.getSharedInstance()
        #if DEBUG
            QG.onStart(appId, withAppGroup:appGroup, setDevProfile: true)
            print ("IN DEBUG")
        #else
            QG.onStart(appId, withAppGroup:appGroup, setDevProfile: false)
            print ("IN ELSE")
        #endif
        
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        //---- Setting Notification Permission Start----//
        center.requestAuthorization(options: [.badge, .carPlay, .alert, .sound]) { (granted, error) in
            print("Granted: \(granted), Error: \(String(describing: error))")
        }
        //---- Setting Notification Permission End----//
        
        
        //---- Set Carousel and Slider Action Button Titles ----//
        /**
         Sdk Will use Default button titles if not set.
         
          If no other action category is defined, Use ``setCarouselNotificationCategoryWithNextButtonTitle``
         
         If you have other action category, Create your action category and Use ``getQGSliderPushActionCategory`` to append both to set to ``setNotificationCategories``
         */
        
        // QGSdk.setCarouselNotificationCategoryWithNextButtonTitle("Play", withOpenAppButtonTitle: "Checkout")
        var categories: Set<UNNotificationCategory> = Set.init()
        categories.insert(QGSdk.getQGSliderPushActionCategory(withNextButtonTitle: ">> Next >>", withOpenAppButtonTitle: "Interested"))
        center.setNotificationCategories(categories)
        
        
        //----- Getting Recommendation Data Start------//
        QG.getRecommendationForModelUserToProduct(completion: { (response) in
            print("Recommendation: \(response)")
        })
        //----- Getting Recommendation Data End------//
        
        return true
    }

    //----- Send Push Token to Appier -----//
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("My token is: \(deviceToken.description)")
        
        let QG = QGSdk.getSharedInstance()
        QG.setToken(deviceToken as Data)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to get token, error: \(error.localizedDescription)")
    }
    
    // MARK: Push Notification Delegates
    
    //---- Handle Background Push and Click Tracking -----//
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // to enable track click on notification
        let QG = QGSdk.getSharedInstance()
        QG.application(application, didReceiveRemoteNotification: userInfo)
        completionHandler(UIBackgroundFetchResult.noData)
    }
    
    //----- Handle Foreground Push -----//
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler
        completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        QGSdk.getSharedInstance().userNotificationCenter(center, willPresent: notification)
        completionHandler([.alert, .badge, .sound]);
    }
    
    //----- Handle Push Response -----//
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler
        completionHandler:@escaping() -> Void) {
        QGSdk.getSharedInstance().userNotificationCenter(center, didReceive: response)
        completionHandler()
    }
}


