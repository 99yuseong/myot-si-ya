//
//  AboutSheetThirdPage.swift
//
//
//  Created by 남유성 on 2/13/24.
//

import SwiftUI

struct AboutSheetThirdPage: View {
    
    @Binding var date: Date
    
    let speechService: SpeechService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 0) {
                        Text("\(date.toKoreanAmPm()) ")
                            .foregroundStyle(.secondary)
                        Text("\(date.toKoreanHours())")
                        Text("시 ")
                            .foregroundStyle(.secondary)
                        Text("\(date.toKoreanMinutes())")
                        Text("분 ")
                            .foregroundStyle(.secondary)
                        Text("\(date.toKoreanSeconds())")
                        Text("초")
                            .foregroundStyle(.secondary)
                    }
                    .aggro(.bold, size: 36)
                    .padding(.top, 9.5)
                    
                    Text("[\(date.toKoreanPronunciation())]")
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
                    speechService.speakInKorean(date.toKoreanTime())
                }
            }
            
            Spacer().frame(height: 24)
            
            Text("""
            The white part means numbers.
            “\(date.toKoreanHours())” is native korean of \(date.toHours()),
            “\(date.toKoreanMinutes())” and “\(date.toKoreanSeconds())” are sino korean of \(date.toMinutes()) and \(date.toSeconds()).
            """)
            .aggro(.light, size: 16)
            
            Spacer().frame(height: 32)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 16) {
                    KoreanPronsListView("AM", "오전", "o-jeon")
                    KoreanPronsListView("PM", "오후", "o-hu")
                    KoreanPronsListView("Hour", "시", "si")
                    KoreanPronsListView("Minute", "분", "bun")
                    KoreanPronsListView("Second", "초", "cho")
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
