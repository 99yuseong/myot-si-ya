//
//  TimerMainView.swift
//
//
//  Created by 남유성 on 2/4/24.
//

import SwiftUI

struct TimerMainView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var selectedHour = 0
    @State private var selectedMinute = 0
    @State private var selectedSecond = 1
    @State private var remainingTime = 0
    @State private var totalTime = 0
    
    @State private var isPresentingSheet = false
    
    @State private var isLinkActive = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var isPortrait: Bool = false
        
    var body: some View {
        NavigationStack {
            GeometryReader { gr in
                VStack(spacing: 0) {
                    HStack {
                        TimerMainDetailView(
                            selectedHour: $selectedHour,
                            selectedMinute: $selectedMinute,
                            selectedSecond: $selectedSecond,
                            isPresentingSheet: $isPresentingSheet
                        )
                        .padding([.top, .leading], 100)
                        Spacer()
                    }
                    
                    VStack {
                        if gr.size.width <= 834 { // ipad mini, 11-inch portrait
                            Spacer()
                            VStack(spacing: 0) {
                                MultiTimerPickerView(
                                    selectedHour: $selectedHour,
                                    selectedMinute: $selectedMinute,
                                    selectedSecond: $selectedSecond,
                                    type: .small
                                )
                                
                                ControlButton(icon: Icon.plus) {
                                    isLinkActive = true
                                    totalTime = selectedHour * 3600 + selectedMinute * 60 + selectedSecond
                                    remainingTime = selectedHour * 3600 + selectedMinute * 60 + selectedSecond
                                }
                                .navigationDestination(isPresented: $isLinkActive) {
                                    TimerProgressView(
                                        remainingTime: $remainingTime,
                                        totalTime: $totalTime,
                                        isLinkActive: $isLinkActive
                                    )
                                }
                            }
                        } else if gr.size.width <= 1133 { // ipad mini landscape, 12.9 inch portrait
                            Spacer()
                            HStack {
                                MultiTimerPickerView(
                                    selectedHour: $selectedHour,
                                    selectedMinute: $selectedMinute,
                                    selectedSecond: $selectedSecond,
                                    type: .small
                                )
                                Spacer()
                                
                                ControlButton(icon: Icon.plus) {
                                    isLinkActive = true
                                    totalTime = selectedHour * 3600 + selectedMinute * 60 + selectedSecond
                                    remainingTime = selectedHour * 3600 + selectedMinute * 60 + selectedSecond
                                }
                                .navigationDestination(isPresented: $isLinkActive) {
                                    TimerProgressView(
                                        remainingTime: $remainingTime,
                                        totalTime: $totalTime,
                                        isLinkActive: $isLinkActive
                                    )
                                }
                            }
                            .padding([.leading, .trailing], 100)
                        } else {
                            if gr.size.width >= 1366 {
                                Spacer()
                            }
                            HStack(spacing: 0) {
                                MultiTimerPickerView(
                                    selectedHour: $selectedHour,
                                    selectedMinute: $selectedMinute,
                                    selectedSecond: $selectedSecond,
                                    type: .large
                                )
                                Spacer()
                                ControlButton(icon: Icon.plus) {
                                    isLinkActive = true
                                    totalTime = selectedHour * 3600 + selectedMinute * 60 + selectedSecond
                                    remainingTime = selectedHour * 3600 + selectedMinute * 60 + selectedSecond
                                }
                                .navigationDestination(isPresented: $isLinkActive) {
                                    TimerProgressView(
                                        remainingTime: $remainingTime,
                                        totalTime: $totalTime,
                                        isLinkActive: $isLinkActive
                                    )
                                }
                            }
                            .padding([.leading, .trailing], gr.size.width >= 1366 ? 100 : 50)
                        }
                        Spacer()
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .background(colorScheme == .light ? Color.bgLight : Color.bgDark)
            }
//            .onRotate { newOrientation in
//                switch newOrientation {
//                case .portrait, .portraitUpsideDown:
//                    isPortrait = true
//                case .landscapeLeft, .landscapeRight:
//                    isPortrait = false
//                default:
//                    break
//                }
//            }
        }
    }
}

#Preview {
    TimerMainView()
}
