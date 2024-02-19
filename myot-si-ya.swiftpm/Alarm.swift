//
//  Alarm.swift
//  
//
//  Created by 남유성 on 2/15/24.
//

import SwiftUI

struct AlarmModel: Codable {
    var timeSection: Int
    var hour: Int
    var minute: Int
    var isOn: Bool
    var id = UUID()
    
    func toAlarm() -> Alarm {
        Alarm(self)
    }
    
    mutating func toggle() {
        isOn.toggle()
    }
    
    init(_ alarm: Alarm) {
        self.timeSection = alarm.timeSection
        self.hour = alarm.hour
        self.minute = alarm.minute
        self.isOn = alarm.isOn
        self.id = alarm.id
    }
}

struct AlarmsModel: Codable {
    var data: [AlarmModel]
    
    func toAlarms() -> Alarms {
        Alarms(data: data.map { $0.toAlarm() })
    }
}

class Alarms: ObservableObject {
    @Published var data: [Alarm]
    
    init(data: [Alarm]) {
        self.data = data
    }
    
    func update(to data: Alarms) {
        self.data = data.data
    }
}

class Alarm: ObservableObject, Identifiable {
    @Published var timeSection: Int
    @Published var hour: Int
    @Published var minute: Int
    @Published var isOn: Bool
    
    let id: UUID
    
    init(timeSection: Int, hour: Int, minute: Int, isOn: Bool) {
        self.timeSection = timeSection
        self.hour = hour
        self.minute = minute
        self.isOn = isOn
        self.id = UUID()
    }
    
    init(_ alarmModel: AlarmModel) {
        self.timeSection = alarmModel.timeSection
        self.hour = alarmModel.hour
        self.minute = alarmModel.minute
        self.isOn = alarmModel.isOn
        self.id = alarmModel.id
    }
    
    static func <(lhs: Alarm, rhs: Alarm) -> Bool {
        if lhs.timeSection == rhs.timeSection {
            if lhs.hour == rhs.hour {
                return lhs.minute < rhs.minute
            }
            return lhs.hour < rhs.hour
        }
        return lhs.timeSection < rhs.timeSection
    }
}
