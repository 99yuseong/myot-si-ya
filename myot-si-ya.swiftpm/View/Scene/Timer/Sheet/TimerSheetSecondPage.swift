//
//  TimerSheetSecondPage.swift
//
//
//  Created by 남유성 on 2/14/24.
//

import SwiftUI

struct TimerSheetSecondPage: View {
    
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int
    @Binding var selectedSecond: Int
    
    @State var isSheetPresented: Bool = false
    
    let speechService: SpeechService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 60) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text("For example, Let’s set timer at")
                        .aggro(.light, size: 20)
                    
                    Spacer().frame(height: 12)
                    
                    HStack(spacing: 0) {
                        Text("After ")
                        
                        if selectedHour != 0 {
                            Text("\(selectedHour)")
                            Text("h ")
                                .foregroundStyle(.secondary)
                        }
                        
                        if selectedMinute != 0 {
                            Text("\(selectedMinute)")
                            Text("m ")
                                .foregroundStyle(.secondary)
                        }
                        
                        if selectedSecond != 0 {
                            Text("\(selectedSecond)")
                            Text("s ")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .aggro(.bold, size: 36)
                }
                .padding(.bottom, 20)
                
                Spacer()
                
                IconButton(
                    Icon.upDown,
                    contentSize: 40,
                    btnSize: CGSize(width: 80, height: 80)
                ) {
                    isSheetPresented.toggle()
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                if selectedHour == 0 && selectedMinute == 0 && selectedSecond == 0 {
                    selectedHour = 11
                    selectedMinute = 59
                    selectedSecond = 59
                }
            } content: {
                ZStack {
                    Color.bg
                        .scaleEffect(1.5)
                    
                    HStack(spacing: -12) {
                        Text("After")
                        
                        HStack {
                            TimePickerView(
                                selectedItem: $selectedHour,
                                items: Array(0..<12),
                                isLoop: true,
                                type: .small
                            )
                            Text("h")
                        }
                        
                        HStack(spacing: 4) {
                            TimePickerView(
                                selectedItem: $selectedMinute,
                                items: Array(0..<60),
                                isLoop: true,
                                type: .small
                            )
                            Text("m")
                        }
                        
                        HStack(spacing: 4) {
                            TimePickerView(
                                selectedItem: $selectedSecond,
                                items: Array(0..<60),
                                isLoop: true,
                                type: .small
                            )
                            Text("s")
                        }
                    }
                    .aggro(.bold, size: 40)
                }
            }
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Timer will goes off")
                        .aggro(.light, size: 20)
                    
                    HStack(spacing: 0) {
                        if selectedHour != 0 {
                            Text(koreanHour())
                            Text("시간 ")
                                .foregroundStyle(.secondary)
                        }
                        
                        if selectedMinute != 0 {
                            Text(koreanMinute())
                            Text("분 ")
                                .foregroundStyle(.secondary)
                        }
                        
                        if selectedSecond != 0 {
                            Text(koreanSecond())
                            Text("초 ")
                                .foregroundStyle(.secondary)
                        }
                        Text("후")
                    }
                    .aggro(.bold, size: 36)
                    .padding(.top, 9.5)
                    
                    Text("[\(koreanPronunciation()) hu]")
                        .aggro(.light, size: 16)
                        .foregroundStyle(.tertiary)
                        .padding(.bottom, 9.5)
                }
                
                Spacer()
                
                IconButton(
                    Icon.sound,
                    contentSize: 40,
                    btnSize: CGSize(width: 80, height: 80)
                ) {
                    speechService.speakInKorean(koreanTime() + " 후")
                }
            }
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("When timer goes off,\nThe timer set in")
                        .aggro(.light, size: 20)
                    
                    
                    
                    HStack(spacing: 0) {
                        if selectedHour != 0 {
                            Text(koreanHour())
                            Text("시간 ")
                                .foregroundStyle(.secondary)
                        }
                        
                        if selectedMinute != 0 {
                            Text(koreanMinute())
                            Text("분 ")
                                .foregroundStyle(.secondary)
                        }
                        
                        if selectedSecond != 0 {
                            Text(koreanSecond())
                            Text("초 ")
                                .foregroundStyle(.secondary)
                        }
                        Text("전")
                    }
                    .aggro(.bold, size: 36)
                    .padding(.top, 9.5)
                    
                    Text("[\(koreanPronunciation()) jeon]")
                        .aggro(.light, size: 16)
                        .foregroundStyle(.tertiary)
                        .padding(.bottom, 9.5)
                }
                
                Spacer()
                
                IconButton(
                    Icon.sound,
                    contentSize: 40,
                    btnSize: CGSize(width: 80, height: 80)
                ) {
                    speechService.speakInKorean(koreanTime() + " 전")
                }
            }
        }
        .frame(width: 680)
    }
}

extension TimerSheetSecondPage {
    func koreanTime() -> String {
        var koreanTime = ""
        
        if selectedHour != 0 {
            koreanTime += koreanHour() + "시간"
        }
        
        if selectedMinute != 0 {
            koreanTime += " " + koreanMinute() + "분"
        }
        
        if selectedSecond != 0 {
            koreanTime += " " + koreanMinute() + "초"
        }
        
        return koreanTime
    }
    
    func koreanHour() -> String {
        selectedHour.nativeKoreanTime!
    }
    
    func koreanMinute() -> String {
        selectedMinute.sinoKoreanTime!
    }
    
    func koreanSecond() -> String {
        selectedSecond.sinoKoreanTime!
    }
    
    func koreanPronunciation(isAmPm: Bool = true) -> String {
        
        var pron: String = ""
        
        if selectedHour != 0 {
            pron += selectedHour.nativeTimePronunciation! + "-sigan"
        }
        
        if selectedMinute != 0 {
            pron += "  " + selectedMinute.sinoTimePronunciation! + "-bun"
        }
        
        if selectedSecond != 0 {
            pron += "  " + selectedSecond.sinoTimePronunciation! + "-cho"
        }
        
        return pron
    }
}
