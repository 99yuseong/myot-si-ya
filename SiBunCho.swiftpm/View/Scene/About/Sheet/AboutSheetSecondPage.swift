//
//  AboutSheetSecondPage.swift
//
//
//  Created by 남유성 on 2/13/24.
//

import SwiftUI

struct AboutSheetSecondPage: View {
    
    @Binding var date: Date
    
    let speechService: SpeechService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("For example, Let's Read times")
                .aggro(.light, size: 20)
            
            Spacer().frame(height: 12)
            
            HStack(spacing: 0) {
                Text("\(date.toAmPm()) ")
                    .foregroundStyle(.secondary)
                Text("\(date.toHours())")
                Text("h ")
                    .foregroundStyle(.secondary)
                Text("\(date.toMinutes())")
                Text("m ")
                    .foregroundStyle(.secondary)
                Text("\(date.toSeconds())")
                Text("s")
                    .foregroundStyle(.secondary)
            }
            .aggro(.bold, size: 36)
            
            Spacer().frame(height: 32)
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("In korean, you can say")
                        .aggro(.light, size: 20)
                    
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
            
            Spacer().frame(height: 32)
            
            Text("""
            Let's start with the dark gray part.
            In Korean, AM and PM are “오전” and “오후”.
            Hour, minute and second are “시”, “분”, “초”.
            """)
                .aggro(.light, size: 16)
            
            Spacer().frame(height: 48)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 16) {
                    KoreanPronsListView("AM", "오전", "o-jeon")
                    KoreanPronsListView("PM", "오후", "o-hu")
                    KoreanPronsListView("Hour", "시", "si")
                    KoreanPronsListView("Minute", "분", "bun")
                    KoreanPronsListView("Second", "초", "cho")
                }
            }
        }
        .frame(width: 600)
    }
}
