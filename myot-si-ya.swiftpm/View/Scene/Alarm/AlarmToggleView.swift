//
//  AlarmToggleView.swift
//
//
//  Created by 남유성 on 2/14/24.
//

import SwiftUI

struct AlarmToggleView: View {
    
    @Binding var alarms: Alarms
    @ObservedObject var alarm: Alarm
    @Binding var isDeleting: Bool
    @State private var isSheetPresented: Bool = false

    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            VStack(alignment: .trailing, spacing: -6) {
                Text(koreanAmPm())
                Text(koreanHour() + "시")
                Text(koreanMinute() + "분")
            }
            
            Spacer()
                .frame(height: 6)
            
            Text("\(hour()):\(minute()) \(amPm())")
                .aggro(.light, size: 20)
                .foregroundStyle(.secondary)
            
            Spacer()
                .frame(height: 24)
            
            if isDeleting || isSheetPresented {
                HStack {
                    Spacer()
                    Button {
                        withAnimation {
                            removeAlarm()
                            alarms.data.sort(by: <)
                            if alarms.data.isEmpty {
                                isDeleting = false
                            }
                        }
                    } label: {
                        Image(systemName: Icon.cancel)
                            .font(.system(size: 18, weight: .bold))
                            .frame(width: 31, height: 31)
                            .foregroundStyle(.primary)
                    }
                    .background(.red)
                    .clipShape(Circle())
                }
            } else {
                Toggle(isOn: $alarm.isOn) {}
                    .toggleStyle(SwitchToggleStyle(tint: Color.green))
                    .onTapGesture {
                        isSheetPresented = false
                    }
                    .onReceive(alarm.$isOn) { isOn in
                        updateAlarm()
                        NotificationService.shared.scheduleAlarm(alarm, isOn)
                    }
            }
        }
        .aggro(.bold, size: 32)
        .frame(width: 132)
        .padding(24)
        .background(Color.bg)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.tertiary, lineWidth: 1)
        )
        .onTapGesture {
            withAnimation {
                isSheetPresented.toggle()
            }
        }
        .popover(isPresented: $isSheetPresented) {
            MultiAlarmPickerView(
                selectedAmPm: $alarm.timeSection,
                selectedHour: $alarm.hour,
                selectedMinute: $alarm.minute,
                type: .small
            )
            .padding()
            .background(Color.bg)
        }
    }
}

extension AlarmToggleView {
    func koreanAmPm() -> String {
        alarm.timeSection == 0 ? "오전" : "오후"
    }
    
    func koreanHour() -> String {
        if alarm.hour == 0 {
            return "열두"
        }
        
        return alarm.hour.nativeKoreanTime!
    }
    
    func koreanMinute() -> String {
        alarm.minute.sinoKoreanTime!
    }
    
    func amPm() -> String {
        alarm.timeSection == 0 ? "AM" : "PM"
    }
    
    func hour() -> String {
        if alarm.hour == 0 {
            return "12"
        }
        
        return "\(alarm.hour)"
    }
    
    func minute() -> String {
        alarm.minute < 10 ? "0\(alarm.minute)" : "\(alarm.minute)"
    }
    
    func removeAlarm() {
        UserDefaults.removeAlarm(alarm.id)
        alarms.data.removeAll() { $0.id == alarm.id }
    }
    
    func updateAlarm() {
        UserDefaults.updateAlarm(alarm.id, isOn: alarm.isOn)
    }
}
