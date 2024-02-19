//
//  AppDelegate.swift
//  myot-si-ya
//
//  Created by 남유성 on 2/16/24.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    var notifDelegate = NotificationDelegate()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        UNUserNotificationCenter.current().delegate = notifDelegate
        return true
//        if #available(iOS 10.0, *) {
//            let notiCenter = UNUserNotificationCenter.current()
//            notiCenter.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { didAllow, e in
//                if didAllow {
//                    //사용자가 Allow
//                } else {
//                    //사용자가 Not Allow
//                }
//            })
//        }
//                return true
    }
    
//    func
}
