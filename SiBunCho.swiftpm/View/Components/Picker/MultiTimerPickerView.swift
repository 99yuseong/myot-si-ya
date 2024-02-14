//
//  MultiTimerPickerView.swift
//
//
//  Created by 남유성 on 2/5/24.
//

import SwiftUI

struct MultiTimerPickerView: View {
    
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int
    @Binding var selectedSecond: Int
    
    let type: PickerType
    
    let hours = Array(0..<12).map { $0.nativeKoreanTime! }
    let minutes = Array(0..<60).map { $0.sinoKoreanTime! }
    let seconds = Array(0..<60).map { $0.sinoKoreanTime! }
    
    var body: some View {
        ZStack {
            HStack(spacing: type == .large ? 24 : 16) {
                TimePickerView(
                    selectedItem: $selectedHour,
                    items: hours,
                    isLoop: true,
                    type: type
                )
                Text("시간")
                TimePickerView(
                    selectedItem: $selectedMinute,
                    items: minutes,
                    isLoop: true,
                    type: type
                )
                Text("분")
                TimePickerView(
                    selectedItem: $selectedSecond,
                    items: seconds,
                    isLoop: true,
                    type: type
                )
                Text("초")
            }
            .aggro(.medium, size: type == .large ? 40 : 24)
            
            VStack { // prevent touch
                Color.bg
                    .contentShape(Rectangle())
                    .frame(height: 42)
                
                Spacer()
                
                Color.bg
                    .contentShape(Rectangle())
                    .frame(height: 42)
            }
            .frame(height: type == .large ? 84 * 5 : 48 * 6)
        }
        .background(Color.bg)
    }
}
