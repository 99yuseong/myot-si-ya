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
            .requestAuthorization(options: [.alert, .sound, .criticalAlert]) { granted, error in
                if granted == true && error == nil { }
            }
    }
    
    private func addAlarm(alarm: Alarm) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in
            if granted {
                let content = UNMutableNotificationContent()
                content.title = "Alarm"
                content.body = Date().toFormat("hh:mm a")
                content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "Timer.mp3"))
                
                var dateComponents = DateComponents()
                dateComponents.calendar = Calendar.current
                dateComponents.hour = alarm.timeSection == 0 ? alarm.hour : alarm.hour + 12
                dateComponents.minute = alarm.minute
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(identifier: "alarm" + alarm.id.uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
    
    private func removeAlarm(_ alarm: Alarm) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["alarm" + alarm.id.uuidString])
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["alarm" + alarm.id.uuidString])
    }
    
    func addTimer(after seconds: Int) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) { granted, _ in
            if granted {
                let content = UNMutableNotificationContent()
                content.title = "Timer"
                content.body = "The set time has ended!"
                content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "Timer.mp3"))
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds), repeats: false)
                let request = UNNotificationRequest(identifier: "timer", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
    
    func removeTimer() {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["timer"])
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["timer"])
    }
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.identifier.hasPrefix("alarm") {
            DispatchQueue.main.async {
                AppState.shared.selectedTab = 1
            }
        }
        
        if response.notification.request.identifier.hasPrefix("timer") {
            DispatchQueue.main.async {
                AppState.shared.selectedTab = 2
            }
        }
        
        completionHandler()
    }
}

