//
//  File.swift
//  
//
//  Created by 남유성 on 2/16/24.
//

import Foundation
import UserNotifications

class NotificationService {
    
    static let shared = NotificationService()
    
    private init() {}
    
    func scheduleAlarm(_ alarm: Alarm, _ isOn: Bool) {
        if isOn {
            UNUserNotificationCenter
                .current()
                .getNotificationSettings { settings in
                    
                switch settings.authorizationStatus {
                case .notDetermined:
                    self.requestPermission()
                case .authorized, .provisional:
                    self.addAlarm(alarm: alarm)
                default:
                    break
                }
            }
        } else {
            removeAlarm(alarm)
        }
    }
    
    private func requestPermission() -> Void {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                if granted == true && error == nil { }
            }
    }
    
    private func addAlarm(alarm: Alarm) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in
            if granted {
                let content = UNMutableNotificationContent()
                content.title = "알람"
                content.body = "\(alarm.hour):\(alarm.minute) \(alarm.timeSection == 0 ? "AM":"PM")"
                content.sound = UNNotificationSound.default
                
                var dateComponents = DateComponents()
                dateComponents.calendar = Calendar.current
                dateComponents.hour = alarm.timeSection == 0 ? alarm.hour : alarm.hour + 12
                dateComponents.minute = alarm.minute
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(identifier: alarm.id.uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
    
    private func removeAlarm(_ alarm: Alarm) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [alarm.id.uuidString])
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.id.uuidString])
    }
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .badge, .sound])
    }
}

