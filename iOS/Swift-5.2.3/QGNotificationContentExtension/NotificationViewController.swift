//
//  NotificationViewController.swift
//  ContentExtension
//
//  Created by Appier on 2019/8/23.
//  Copyright © 2019 Appier. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension, iCarouselDelegate, iCarouselDataSource {

    let APP_GROUP:String = "group.com.appier.NickTest.notification"
    
    @IBOutlet weak var carousel: iCarousel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _ = QGNotificationSdk.sharedInstance(withAppGroup: APP_GROUP)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        QGNotificationSdk.sharedInstance(withAppGroup: APP_GROUP).viewDidLoad(with: carousel)
    }
    
    func didReceive(_ notification: UNNotification) {
        QGNotificationSdk.sharedInstance(withAppGroup: APP_GROUP).didReceive(notification)
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        if let theContext = self.extensionContext {
            let qgsdk = QGNotificationSdk.sharedInstance(withAppGroup: APP_GROUP)
            qgsdk.didReceive(response, with: theContext, completionHandler: completion)
        }
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return QGNotificationSdk.sharedInstance(withAppGroup: APP_GROUP).numberOfItems(in: carousel)
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        return QGNotificationSdk.sharedInstance(withAppGroup: APP_GROUP).carousel(carousel, viewForItemAt: index, reusing: view)
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        return QGNotificationSdk.sharedInstance(withAppGroup: APP_GROUP).carousel(carousel, valueFor: option, withDefault: value)
    }
    
    func carouselItemWidth(_ carousel: iCarousel) -> CGFloat {
        return QGNotificationSdk.sharedInstance(withAppGroup: APP_GROUP).carouselItemWidth(carousel)
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        if #available(iOS 12.0, *) {
            if let theContext = self.extensionContext {
                QGNotificationSdk.sharedInstance(withAppGroup: APP_GROUP).carousel(carousel, didSelectItemAt: index, with: theContext)
            }
        } else {
            //Fallback on earlier versions
        }
    }
    
    func carouselDidEndDragging(_ carousel: iCarousel, willDecelerate decelerate: Bool) {
        if #available(iOS 12.0, *) {
            QGNotificationSdk.sharedInstance(withAppGroup: APP_GROUP).carouselDidEndDragging(carousel, willDecelerate: decelerate)
        }
    }
    
    deinit {
        self.carousel.delegate = nil
        self.carousel.dataSource = nil
    }
    
}
