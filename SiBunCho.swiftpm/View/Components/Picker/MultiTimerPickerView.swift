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
    
    let hours = Array(0..<24)
    let minutes = Array(0..<60)
    let seconds = Array(0..<60)
    
    var body: some View {
        HStack(spacing: type == .large ? 24 : 16) {
            TimePickerView(
                selectedItem: $selectedHour,
                items: hours,
                isNative: true,
                type: type
            )
            Text("시간")
            TimePickerView(
                selectedItem: $selectedMinute,
                items: minutes,
                isNative: false,
                type: type
            )
            Text("분")
            TimePickerView(
                selectedItem: $selectedSecond,
                items: seconds,
                isNative: false,
                type: type
            )
            Text("초")
        }
        .aggro(.medium, size: type == .large ? 40 : 24)
    }
}