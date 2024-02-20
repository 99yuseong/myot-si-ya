//
//  UserDefaults.swift
//
//
//  Created by 남유성 on 2/19/24.
//

import Foundation

extension UserDefaults {
    static func getAlarmsData() -> Alarms {
        guard var alarms = decodeAlarmData() else { return Alarms(data: []) }
    
        return alarms.toAlarms()
    }
    
    static func addAlarm(_ alarm: Alarm) {
        guard var alarms = decodeAlarmData() else {
            let alarmsModel = AlarmsModel(data: [AlarmModel(alarm)])
            
            guard let encodeData = try? JSONEncoder().encode(alarmsModel) else { return }
            UserDefaults.standard.setValue(encodeData, forKey: "alarms")
            return
        }
        
        alarms.data.append(AlarmModel(alarm))
        saveAlarmData(alarms)
    }
    
    static func removeAlarm(_ alarmId: UUID) {
        guard var alarms = decodeAlarmData() else { return }
        
        alarms.data.removeAll { $0.id == alarmId }
        saveAlarmData(alarms)
    }
    
    static func updateAlarm(_ alarmId: UUID, isOn: Bool) {
        guard var alarms = decodeAlarmData() else { return }
        
        for index in 0..<alarms.data.count {
            if alarms.data[index].id == alarmId {
                alarms.data[index].isOn = isOn
            }
        }
        saveAlarmData(alarms)
    }
    
    static func decodeAlarmData() -> AlarmsModel? {
        guard let data = UserDefaults.standard.value(forKey: "alarms") as? Data,
              var alarms = try? JSONDecoder().decode(AlarmsModel.self, from: data) else { return nil }
        
        return alarms
    }
    
    static func saveAlarmData(_ alarms: AlarmsModel) {
        guard let encodeData = try? JSONEncoder().encode(alarms) else { return }
        UserDefaults.standard.set(encodeData, forKey: "alarms")
    }
}
