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
    
    @StateObject var alarms: Alarms = Alarms(data: [])
        
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
                            isDeletingAlarm: $isDeletingAlarm,
                            alarms: alarms
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
                            alarms: alarms,
                            gr: gr
                        )
                        .transition(.backslide)
                        
                    } else {
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 28) {
                                ForEach(alarms.data, id: \.self.id) { alarm in
                                    AlarmToggleView(
                                        alarms: alarms,
                                        alarm: alarm,
                                        isDeleting: $isDeletingAlarm
                                    )
                                }
                                
                                if !isDeletingAlarm {
                                    IconButton(Icon.plus, btnSize: CGSize(width: 82, height: 236)) {
                                        withAnimation {
                                            isSettingAlarm.toggle()
                                        }
                                    }
                                    .background(Color.quaternary)
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
        .onAppear {
            alarms.update(to: UserDefaults.getAlarmsData())
        }
    }
}

