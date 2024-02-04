//
//  TimerMainView.swift
//
//
//  Created by 남유성 on 2/4/24.
//

import SwiftUI

struct TimerMainView: View {

    @State private var selectedHour = 0
    @State private var selectedMinute = 5
    @State private var selectedSecond = 0
    
    let hours = Array(0..<24)
    let minutes = Array(0..<60)
    let seconds = Array(0..<60)
        
        var body: some View {
            VStack {
                Text("Selected item: \(selectedHour) \(selectedMinute) \(selectedSecond)")
                
                HStack {
                    KoreanTimePickerView(
                        selectedItem: $selectedHour,
                        items: hours,
                        isNative: true,
                        type: .large
                    )
                    Text("시간")
                    KoreanTimePickerView(
                        selectedItem: $selectedMinute,
                        items: minutes,
                        isNative: false,
                        type: .large
                    )
                    Text("분")
                    KoreanTimePickerView(
                        selectedItem: $selectedSecond,
                        items: seconds,
                        isNative: false,
                        type: .large
                    )
                    Text("초")
                }
                .aggro(.medium, size: 40)
            }
        }
}

extension UIPickerView {
    open override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric , height: 84 * 5)
    }
}

#Preview {
    TimerMainView()
}
