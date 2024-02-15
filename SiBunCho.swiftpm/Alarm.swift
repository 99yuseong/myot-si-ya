//
//  Alarm.swift
//  SiBunCho
//
//  Created by 남유성 on 2/15/24.
//

import SwiftUI

class Alarm: ObservableObject, Identifiable {
    @Published var timeSection: Int
    @Published var hour: Int
    @Published var minute: Int
    @Published var isOn: Bool
    
    let id = UUID()
    
    init(timeSection: Int, hour: Int, minute: Int, isOn: Bool) {
        self.timeSection = timeSection
        self.hour = hour
        self.minute = minute
        self.isOn = isOn
    }
    
//    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
//        return lhs.id == rhs.id
//    }
}
//
//extension Alarm: Hashable {
//    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
//        return lhs.id == rhs.id
//    }
//}
