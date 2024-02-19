//
//  AlarmMainPickerView.swift
//
//
//  Created by 남유성 on 2/14/24.
//

import SwiftUI

struct AlarmMainPickerView: View {
    
    @Binding var selectedAmPm: Int
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int
    
    @Binding var isSettingAlarm: Bool
    @Binding var alarms: Alarms
    
    let gr: GeometryProxy
    
    var body: some View {
        VStack {
            if gr.size.width <= 834 { // ipad mini, 11-inch portrait
                Spacer()
                VStack(spacing: 0) {
                    MultiAlarmPickerView(
                        selectedAmPm: $selectedAmPm,
                        selectedHour: $selectedHour,
                        selectedMinute: $selectedMinute,
                        type: .small
                    )
                    
                    ControlButton(icon: Icon.plus) {
                        withAnimation {
                            addAlarm()
                            alarms.data.sort(by: <)
                            isSettingAlarm.toggle()
                        }
                    }
                }
            } else if gr.size.width <= 1133 { // ipad mini landscape, 12.9 inch portrait
                Spacer()
                HStack {
                    MultiAlarmPickerView(
                        selectedAmPm: $selectedAmPm,
                        selectedHour: $selectedHour,
                        selectedMinute: $selectedMinute,
                        type: .small
                    )
                    Spacer()
                    
                    ControlButton(icon: Icon.plus) {
                        withAnimation {
                            addAlarm()
                            alarms.data.sort(by: <)
                            isSettingAlarm.toggle()
                        }
                    }
                }
                .padding([.leading, .trailing], 100)
            } else {
                if gr.size.width >= 1366 {
                    Spacer()
                }
                HStack(spacing: 0) {
                    MultiAlarmPickerView(
                        selectedAmPm: $selectedAmPm,
                        selectedHour: $selectedHour,
                        selectedMinute: $selectedMinute,
                        type: .large
                    )
                    
                    Spacer()
                    
                    ControlButton(icon: Icon.plus) {
                        withAnimation {
                            addAlarm()
                            alarms.data.sort(by: <)
                            isSettingAlarm.toggle()
                        }
                    }
                }
                .padding([.trailing], 100)
            }
            Spacer()
        }
    }
    
    func addAlarm() {
        let alarm = Alarm(
            timeSection: selectedAmPm,
            hour: selectedHour,
            minute: selectedMinute,
            isOn: true)
        
        UserDefaults.addAlarm(alarm)
        alarms.data.append(alarm)
    }
}
