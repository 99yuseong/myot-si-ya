//
//  AlarmMainDetailView.swift
//  
//
//  Created by 남유성 on 2/14/24.
//

import SwiftUI

struct AlarmMainDetailView: View {
    
    @Binding var selectedAmPm: Int
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int
    @Binding var isPresentingSheet: Bool
    @Binding var isSettingAlarm: Bool
    @Binding var isDeletingAlarm: Bool
    @Binding var alarms: Alarms
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Hangeul Alarm")
                    .aggro(.bold, size: 32)
                Text("There are other notation instead of 오전 [AM] and 오후 [PM].\nLearn Korean time notations and set alarms.")
                    .aggro(.light, size: 17)
            }
            
            if isSettingAlarm {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Alarm will go off in")
                        .aggro(.light, size: 17)
                    Text("\(hour()):\(minute()) \(amPm())")
                        .aggro(.medium, size: 20)
                }
            }
            
            HStack(spacing: 16) {
                if !isDeletingAlarm {
                    IconButton(text: "Aa") {
                        isPresentingSheet = true
                    }
                    .transition(.opacity)
                    .fullScreenCover(isPresented: $isPresentingSheet) {
                        AlarmMainInfoSheet()
                            .clearBg()
                    }
                    
                    if isSettingAlarm {
                        IconButton(Icon.list) {
                            withAnimation {
                                isSettingAlarm.toggle()
                            }
                        }
                    } else {
                        IconButton(Icon.plus) {
                            withAnimation {
                                isSettingAlarm.toggle()
                            }
                        }
                    }
                    
                }
                
                if isSettingAlarm {
                    IconButton(
                        text: "7am",
                        btnSize: CGSize(width: 64, height: 48)
                    ) {
                        
                        selectedAmPm = 0
                        selectedHour = 7
                        selectedMinute = 0
                    }
                    
                    IconButton(
                        text: "12pm",
                        btnSize: CGSize(width: 80, height: 48)
                    ) {
                        selectedAmPm = 1
                        selectedHour = 12
                        selectedMinute = 0
                    }
                } else {
                    IconButton(Icon.setting) {
                        withAnimation {
                            isDeletingAlarm.toggle()
                        }
                    }
                    .disabled(alarms.data.isEmpty)
                }
            }
            .foregroundStyle(.primary)
        }
        .transition(.opacity)
    }
}

extension AlarmMainDetailView {
    func hour() -> String {
        if selectedHour == 0 {
            return "12"
        }
        
        if selectedHour < 10 {
            return "0\(selectedHour)"
        }
        
        return "\(selectedHour > 12 ? selectedHour - 12 : selectedHour)"
    }
    
    func minute() -> String {
        if selectedMinute < 10 {
            return "0\(selectedMinute)"
        }
        
        return "\(selectedMinute)"
    }
    
    func amPm() -> String {
        selectedAmPm == 0 ? "AM" : "PM"
    }
}
