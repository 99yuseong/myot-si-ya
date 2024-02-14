//
//  TimerSheetThirdPage.swift
//
//
//  Created by 남유성 on 2/14/24.
//

import SwiftUI

struct TimerSheetThirdPage: View {
    
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int
    @Binding var selectedSecond: Int
    
    let speechService: SpeechService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
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
            
            Spacer().frame(height: 24)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("It means after \(selectedHour)h \(selectedMinute)m \(selectedSecond)s.\n")
                if selectedHour != 0 {
                    Text("“\(selectedHour.nativeKoreanTime!)” is native korean of \(selectedHour),")
                }
                if selectedMinute != 0 && selectedSecond != 0 {
                    if selectedMinute == selectedSecond {
                        Text("“\(selectedMinute.sinoKoreanTime!)” is sino korean of \(selectedMinute),")
                    } else {
                        Text("“\(selectedMinute.sinoKoreanTime!)” and “\(selectedSecond.sinoKoreanTime!)” are sino korean of \(selectedMinute) and \(selectedSecond),")
                    }
                } else if selectedMinute != 0 {
                    Text("“\(selectedMinute.sinoKoreanTime!)” is sino korean of \(selectedHour),")
                } else if selectedSecond != 0 {
                    Text("“\(selectedSecond.sinoKoreanTime!)” is sino korean of \(selectedHour),")
                }
                Text("“후” means “After“.")
            }
            .aggro(.light, size: 16)
            
            Spacer().frame(height: 32)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 16) {
                    KoreanPronsListView("Hour", "시간", "si-gan")
                    KoreanPronsListView("Minute", "분", "bun")
                    KoreanPronsListView("Second", "초", "cho")
                    KoreanPronsListView("ago", "전", "jeon")
                    KoreanPronsListView("After", "후", "hu")
                }
                .frame(width: 240)
                .padding(.top, 16 + 18)
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 92 - 16) {
                        Group {
                            Text("Native KR")
                            Text("Sino KR")
                        }
                        .aggro(.medium, size: 15)
                    }
                    .padding(.leading, 82 + 16 + 16)
                    
                    ForEach(1..<11) { num in
                        KoreanPronsListView(
                            "\(num)",
                            num.nativeKorean ?? "",
                            num.nativePronunciation ?? "",
                            num.sinoKoreanTime,
                            num.sinoPronunciation
                        )
                    }
                }
                .frame(width: 360)
            }
        }
        .frame(width: 600)
    }
}

extension TimerSheetThirdPage {
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
            pron += selectedHour.nativeTimePronunciation! + "-si-gan" + " "
        }
        
        if selectedMinute != 0 {
            pron += selectedMinute.sinoTimePronunciation! + "-bun" + " "
        }
        
        if selectedSecond != 0 {
            pron += selectedSecond.sinoTimePronunciation! + "-cho"
        }
        
        return pron
    }
}
