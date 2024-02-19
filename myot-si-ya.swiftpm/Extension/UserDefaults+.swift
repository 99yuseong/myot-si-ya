//
//  UserDefaults.swift
//
//
//  Created by 남유성 on 2/19/24.
//

import Foundation

extension UserDefaults {
    static func getAlarmsData() -> [Alarm] {
        guard let data = UserDefaults.standard.value(forKey: "alarms") as? Data,
              let alarms = try? JSONDecoder().decode([AlarmModel].self, from: data) else { return [] }
        
        return alarms.map { $0.toAlarm() }
    }
    
    static func addAlarm(_ alarm: AlarmModel) {
        guard let data = UserDefaults.standard.value(forKey: "alarms") as? Data else {
            
            guard let encodeData = try? JSONEncoder().encode([alarm]) else { return }
            UserDefaults.standard.setValue(encodeData, forKey: "alarms")
            return
        }
        
        guard var alarms = try? JSONDecoder().decode([AlarmModel].self, from: data) else { return }
        
        alarms.append(alarm)
        UserDefaults.standard.set(alarms, forKey: "alarms")
    }
    
    static func removeAlarm(_ alarmId: UUID) {
        guard let data = UserDefaults.standard.value(forKey: "alarms") as? Data,
              var alarms = try? JSONDecoder().decode([AlarmModel].self, from: data) else { return }
        
        alarms.removeAll { $0.id == alarmId}
        
        UserDefaults.standard.set(alarms, forKey: "alarms")
    }
}
