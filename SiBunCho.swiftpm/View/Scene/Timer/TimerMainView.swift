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
    
    @State private var isPresentingSheet = false
        
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Hangeul Timer")
                            .aggro(.bold, size: 32)
                        Text("Set the time you want (~ 23h 59m 59s)\nand receive notification.")
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
                        .sheet(isPresented: $isPresentingSheet) {
                            AboutMainInfoSheet()
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
                Spacer()
            }
            .padding([.top, .leading], 100)
            
            Spacer()
                .frame(height: 48)
            
            HStack(spacing: 56) {
                ZStack {
                    MultiTimerPickerView(
                        selectedHour: $selectedHour,
                        selectedMinute: $selectedMinute,
                        selectedSecond: $selectedSecond,
                        type: .large
                    )
                    
                    VStack { // prevent touch
                        Color.bgDark
                            .contentShape(Rectangle())
                            .frame(height: 42)
                        
                        Spacer()
                        
                        Color.bgDark
                            .contentShape(Rectangle())
                            .frame(height: 42)
                    }
                    
                }
                .frame(height: 84 * 4)
                
                ControlButton(icon: Icon.plus) {
                    System.shared.log("a")
                }
            }
            .padding([.leading, .trailing], 60)
            
            Spacer()
        }
        .ignoresSafeArea()
        .background(Color.bgDark)
    }
}

#Preview {
    TimerMainView()
}
