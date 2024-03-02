//
//  MultiAlarmPickerView.swift
//
//
//  Created by 남유성 on 2/7/24.
//

import SwiftUI

enum TimeSection: CaseIterable {
    case am
    case pm
    
    var korean: String {
        switch self {
        case .am: 
            return "오전"
        case .pm: 
            return "오후"
        }
    }
}

struct MultiAlarmPickerView: View {
        
    @Binding var selectedAmPm: Int
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int
    
    let type: PickerType
    
    let sections = TimeSection.allCases.map { $0.korean }
    let hours = Array(0..<12).map {
        if $0 == 0 {
            return "열두"
        }
        return $0.nativeKoreanTime!
    }
    let minutes = Array(0..<60).map { $0.sinoKoreanTime! }
    
    var body: some View {
        ZStack {
            HStack(spacing: type == .large ? 24 : 16) {
                TimePickerView(
                    selectedItem: $selectedAmPm,
                    items: sections,
                    isLoop: false, 
                    type: type
                )
                TimePickerView(
                    selectedItem: $selectedHour,
                    items: hours,
                    isLoop: true,
                    type: type
                )
                Text("시")
                TimePickerView(
                    selectedItem: $selectedMinute,
                    items: minutes,
                    isLoop: true,
                    type: type
                )
                Text("분")
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
