//
//  SwiftUIView.swift
//  
//
//  Created by 남유성 on 2/6/24.
//

import SwiftUI

struct TimerMainDetailView: View {
    
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int
    @Binding var selectedSecond: Int
    @Binding var isPresentingSheet: Bool
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Hangeul Timer")
                    .aggro(.bold, size: 32)
                Text("Set the time you want (~ 11h 59m 59s)\nand receive notification.")
                    .aggro(.light, size: 17)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Timer will be activated in")
                    .aggro(.light, size: 17)
                Text("\(selectedHour)h \(selectedMinute)m \(selectedSecond)s")
                    .aggro(.medium, size: 20)
            }
            
            HStack(spacing: 16) {
                IconButton(text: "Aa") {
                    isPresentingSheet = true
                }
                .fullScreenCover(isPresented: $isPresentingSheet) {
                    TimerMainInfoSheet()
                        .clearBg()
                }
                
                IconButton(
                    text: "30s",
                    btnSize: CGSize(width: 64, height: 48)
                ) {
                    selectedHour = 0
                    selectedMinute = 0
                    selectedSecond = 30
                }
                
                IconButton(
                    text: "5m"
                ) {
                    selectedHour = 0
                    selectedMinute = 5
                    selectedSecond = 0
                }
                
                IconButton(text: "1h") {
                    selectedHour = 1
                    selectedMinute = 0
                    selectedSecond = 0
                }
            }
            .foregroundStyle(.primary)
        }
        .transition(.opacity)
    }
}
