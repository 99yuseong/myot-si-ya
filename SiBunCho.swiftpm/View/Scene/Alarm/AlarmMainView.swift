//
//  AlarmMainView.swift
//
//
//  Created by 남유성 on 2/7/24.
//

import SwiftUI

struct AlarmMainView: View {
    @State private var selectedAmPm: Int = 0
    @State private var selectedHour = 0
    @State private var selectedMinute = 0
    
    @State private var isPresentingSheet = false
    @State private var isLinkActive = false
    
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
    var body: some View {
        NavigationStack {
            GeometryReader { gr in
                VStack(spacing: 0) {
                    HStack {
                        Text("\(selectedAmPm) \(selectedHour) \(selectedMinute)")
                        .padding([.top, .leading], 100)
                        Spacer()
                    }
                    
                    VStack {
                        if gr.size.width <= 834 { // ipad mini, 11-inch portrait
                            Spacer()
                            VStack(spacing: 0) {
                                MultiAlarmPickerView(
                                    selectedAmPm: $selectedAmPm,
                                    selectedHour: $selectedHour,
                                    selectedMinute: $selectedMinute,
                                    type: .small
                                )
                                
                                ControlButton(icon: Icon.plus) {
//                                    isLinkActive = true
                                }
//                                .navigationDestination(isPresented: $isLinkActive) {
//                                    TimerProgressView(
//                                        remainingTime: $remainingTime,
//                                        totalTime: $totalTime,
//                                        isLinkActive: $isLinkActive
//                                    )
//                                }
                            }
                        } else if gr.size.width <= 1133 { // ipad mini landscape, 12.9 inch portrait
                            Spacer()
                            HStack {
                                MultiAlarmPickerView(
                                    selectedAmPm: $selectedAmPm,
                                    selectedHour: $selectedHour,
                                    selectedMinute: $selectedMinute,
                                    type: .small
                                )
                                Spacer()
                                
                                ControlButton(icon: Icon.plus) {
//                                    isLinkActive = true
                                }
//                                .navigationDestination(isPresented: $isLinkActive) {
//                                    TimerProgressView(
//                                        remainingTime: $remainingTime,
//                                        totalTime: $totalTime,
//                                        isLinkActive: $isLinkActive
//                                    )
//                                }
                            }
                            .padding([.leading, .trailing], 100)
                        } else {
                            if gr.size.width >= 1366 {
                                Spacer()
                            }
                            HStack(spacing: 0) {
                                MultiAlarmPickerView(
                                    selectedAmPm: $selectedAmPm,
                                    selectedHour: $selectedHour,
                                    selectedMinute: $selectedMinute,
                                    type: .large
                                )
                                
                                Spacer()
                                
                                ControlButton(icon: Icon.plus) {
                                    //                                    isLinkActive = true
                                }
                                //                                .navigationDestination(isPresented: $isLinkActive) {
                                //                                    TimerProgressView(
                                //                                        remainingTime: $remainingTime,
                                //                                        totalTime: $totalTime,
                                //                                        isLinkActive: $isLinkActive
                                //                                    )
                                //                                }
                            }
                            .padding([.trailing], 100)
                        }
                        Spacer()
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .background(Color.bg)
            }
        }
    }
}

#Preview {
    AlarmMainView()
}
