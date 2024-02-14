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
    @State private var isSettingAlarm = false
    @State private var isDeletingAlarm = false
    
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
    var body: some View {
        NavigationStack {
            GeometryReader { gr in
                VStack(spacing: 0) {
                    HStack {
                        AlarmMainDetailView(
                            selectedAmPm: $selectedAmPm,
                            selectedHour: $selectedHour,
                            selectedMinute: $selectedMinute,
                            isPresentingSheet: $isPresentingSheet,
                            isSettingAlarm: $isSettingAlarm,
                            isDeletingAlarm: $isDeletingAlarm
                        )
                        .padding([.top, .leading], 100)
                        Spacer()
                    }
                    
                    if isSettingAlarm {
                        AlarmMainPickerView(
                            selectedAmPm: $selectedAmPm,
                            selectedHour: $selectedHour,
                            selectedMinute: $selectedMinute,
                            isSettingAlarm: $isSettingAlarm,
                            gr: gr
                        )
                        .transition(.backslide)
                    } else {
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 28) {
                                ForEach(0..<2) {
                                    AlarmToggleView(
                                        setAmPm: 1,
                                        setHour: $0,
                                        setMinute: $0,
                                        isOn: true,
                                        isDeleting: $isDeletingAlarm
                                    )
                                }
                                
                                if !isDeletingAlarm {
                                    IconButton(Icon.plus, btnSize: CGSize(width: 82, height: 236)) {
                                        withAnimation {
                                            isSettingAlarm.toggle()
                                        }
                                    }
                                    .background(.quaternary)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                }
                            }
                            .padding([.leading, .trailing], 100)
                        }
                        .scrollIndicators(.hidden)
                        .transition(.slide)
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
