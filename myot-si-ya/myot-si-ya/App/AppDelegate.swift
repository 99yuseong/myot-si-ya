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
    }
}
