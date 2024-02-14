//
//  AlarmSheetSecondPage.swift
//
//
//  Created by 남유성 on 2/13/24.
//

import SwiftUI

struct AlarmSheetSecondPage: View {
    
    @State var selectedTimeSection: Int = 0
    @State var selectedHour: Int = 0
    @State var selectedMinute: Int = 0
    
    @State var isSheetPresented: Bool = false
    
    let speechService: SpeechService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 60) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text("For example, Let's Read times")
                        .aggro(.light, size: 20)
                    
                    Spacer().frame(height: 12)
                    
                    HStack(spacing: 0) {
                        Text("\(selectedTimeSection == 0 ? "AM" : "PM") ")
                            .foregroundStyle(.secondary)
                        Text("\(selectedHour == 0 ? 12 : selectedHour)")
                        Text("h ")
                            .foregroundStyle(.secondary)
                        
                        if selectedMinute != 0 {
                            Text("\(selectedMinute)")
                            Text("m ")
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
                ZStack {
                    Color.bg
                        .scaleEffect(1.5)
                    
                    HStack(spacing: 0) {
                        TimePickerView(
                            selectedItem: $selectedTimeSection,
                            items: ["AM", "PM"],
                            isLoop: false,
                            type: .small
                        )
                        
                        HStack(spacing: 4) {
                            TimePickerView(
                                selectedItem: $selectedHour,
                                items: [12] + Array(1..<12),
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
                    }
                    .aggro(.bold, size: 40)
                    .padding()
                }
            }
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("In korean, you can say")
                        .aggro(.light, size: 20)
                    
                    HStack(spacing: 0) {
                        Text(koreanTimeSecton() + " ")
                            .foregroundStyle(.secondary)
                        Text(koreanHour())
                        Text("시 ")
                            .foregroundStyle(.secondary)
                        
                        if selectedMinute != 0 {
                            Text(koreanMinute())
                            Text("분 ")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .aggro(.bold, size: 36)
                    .padding(.top, 9.5)
                    
                    Text("[\(koreanPronunciation())]")
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
                    speechService.speakInKorean(koreanTime())
                }
            }
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Also, you can say")
                        .aggro(.light, size: 20)
                    
                    HStack(spacing: 0) {
                        Text(koreanTimeSecton(isAmPm: false) + " ")
                            .foregroundStyle(.secondary)
                        Text(koreanHour())
                        Text("시 ")
                            .foregroundStyle(.secondary)
                        
                        if selectedMinute != 0 {
                            Text(koreanMinute())
                            Text("분 ")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .aggro(.bold, size: 36)
                    .padding(.top, 9.5)
                    
                    Text("[\(koreanPronunciation(isAmPm: false))]")
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
                    speechService.speakInKorean(koreanTime(isAmPm: false))
                }
            }
            
            if isJajeong() || isJeongO() {
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Also, you can say")
                            .aggro(.light, size: 20)
                        
                        
                        Text(isJajeong() ? "자정" : "정오")
                            .aggro(.bold, size: 36)
                            .padding(.top, 9.5)
                        
                        Text("[\(isJajeong() ? "ja-jeong" : "jeong-o")]")
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
                        speechService.speakInKorean(isJajeong() ? "자정" : "정오")
                    }
                }
            }
        }
        .frame(width: 600)
    }
}

extension AlarmSheetSecondPage {
    func isJajeong() -> Bool {
        return selectedTimeSection == 0 && selectedHour == 0 && selectedMinute == 0
    }
    
    func isJeongO() -> Bool {
        return selectedTimeSection == 1 && selectedHour == 0 && selectedMinute == 0
    }
    
    func koreanTime(isAmPm: Bool = true) -> String {
        let koreanTime = koreanTimeSecton(isAmPm: isAmPm) + " " + koreanHour() + "시"
        
        if selectedMinute != 0 {
            return koreanTime + " " + koreanMinute() + "분"
        }
        
        return koreanTime
    }
    
    func koreanTimeSecton(isAmPm: Bool = true) -> String {
        if isAmPm {
            return selectedTimeSection == 0 ? "오전" : "오후"
        }
        
        let hour = selectedHour
        
        if selectedTimeSection == 0 {
            if (0..<3) ~= hour { return "밤" }
            if (3..<6) ~= hour { return "새벽" }
            if (6..<12) ~= hour { return "아침" }
        } else {
            if (0..<6) ~= hour { return "낮" }
            if (6..<9) ~= hour { return "저녁" }
        }
        
        return "밤"
    }
    
    func koreanHour() -> String {
        if selectedHour == 0 {
            return 12.nativeKoreanTime!
        }
        
        return selectedHour.nativeKoreanTime!
    }
    
    func koreanMinute() -> String {
        selectedMinute.sinoKoreanTime!
    }
    
    func koreanPronunciation(isAmPm: Bool = true) -> String {
        
        var pron: String = ""
        
        pron += koreanTimeSectionPronunciation(isAmPm: isAmPm)
        pron += "  " + selectedHour.nativeTimePronunciation! + "-si"
        
        if selectedMinute != 0 {
            pron += "  " + selectedMinute.sinoTimePronunciation! + "-bun"
        }
        
        return pron
    }
    
    func koreanTimeSectionPronunciation(isAmPm: Bool = true) -> String {
        if isAmPm {
            return selectedTimeSection == 0 ? "ojeon" : "ohu"
        }
        
        let hour = selectedHour
        
        if selectedTimeSection == 0 {
            if (0..<3) ~= hour { return "bam" }
            if (3..<6) ~= hour { return "sae-byeok" }
            if (6..<12) ~= hour { return "a-chim" }
        } else {
            if (0..<6) ~= hour { return "nat" }
            if (6..<9) ~= hour { return "jeo-nyeok" }
        }
        
        return "bam"
    }
}

#Preview {
    @State var date: Date = Date()
    return AlarmSheetSecondPage(speechService: SpeechService())
}
