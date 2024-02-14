//
//  AlarmToggleView.swift
//
//
//  Created by 남유성 on 2/14/24.
//

import SwiftUI

struct AlarmToggleView: View {
    
    @State var setAmPm: Int
    @State var setHour: Int
    @State var setMinute: Int
    @State var isOn: Bool
    @Binding var isDeleting: Bool
    
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
            
            if isDeleting {
                HStack {
                    Spacer()
                    Button {
                         
                    } label: {
                        Image(systemName: Icon.cancel)
                            .font(.system(size: 18, weight: .bold))
                            .frame(width: 31, height: 31)
                            .foregroundStyle(.primary)
                    }
                    .background(.red)
                    .clipShape(Circle())
//                    .transition(.opacity)
//                    .animation(.easeInOut, value: isDeleting)
                }
            } else {
                Toggle(isOn: $isOn) {
                    
                }
                .toggleStyle(SwitchToggleStyle(tint: Color.green))
            }
        }
        .aggro(.bold, size: 32)
        .frame(width: 132)
        .padding(24)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.tertiary, lineWidth: 1)
        )        
    }
}

extension AlarmToggleView {
    func koreanAmPm() -> String {
        setAmPm == 0 ? "오전" : "오후"
    }
    
    func koreanHour() -> String {
        setHour.nativeKoreanTime!
    }
    
    func koreanMinute() -> String {
        setMinute.sinoKoreanTime!
    }
    
    func amPm() -> String {
        setAmPm == 0 ? "AM" : "PM"
    }
    
    func hour() -> String {
        "\(setHour)"
    }
    
    func minute() -> String {
        setMinute < 10 ? "0\(setMinute)" : "\(setMinute)"
    }
}

#Preview {
    @State var isDeleting = true
    return AlarmToggleView(setAmPm: 1, setHour: 12, setMinute: 24, isOn: true, isDeleting: $isDeleting)
}
