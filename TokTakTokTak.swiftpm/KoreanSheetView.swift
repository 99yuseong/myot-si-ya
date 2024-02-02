//
//  KoreanSheetView.swift
//  TokTakTokTak
//
//  Created by 남유성 on 2/2/24.
//

import SwiftUI

struct KoreanSheetView: View {
    
    private let speechService = SpeechService()
    private let date = Date()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 0) {
                    Text("\(date.toAmPm()) ")
                        .foregroundStyle(.secondary)
                    Text(date.toFormat("h"))
                    Text("h ")
                        .foregroundStyle(.secondary)
                    Text(date.toFormat("m"))
                    Text("m ")
                        .foregroundStyle(.secondary)
                    Text(date.toFormat("s"))
                    Text("s")
                        .foregroundStyle(.secondary)
                }
                
                HStack(spacing: 0) {
                    Text("\(date.toKoreanAmPm()) ")
                        .foregroundStyle(.secondary)
                    Text(date.toKoreanHours())
                    Text("시 ")
                        .foregroundStyle(.secondary)
                    Text(date.toKoreanMinutes())
                    Text("분 ")
                        .foregroundStyle(.secondary)
                    Text(date.toKoreanSeconds())
                    Text("초")
                        .foregroundStyle(.secondary)
                }
            }
            .aggro(.bold, size: 36)
            Spacer()
            IconButton(Icon.sound, contentSize: 40, btnSize: 80) {
                speechService.speakInKorean(date.toKoreanTime())
            }
        }
        .padding([.leading, .trailing], 60)
        
        Spacer()
            .frame(height: 48)
        
        VStack(alignment: .leading) {
            HStack(spacing: 92 - 16) {
                Group {
                    Text("Native KR")
                    Text("Sino KR")
                }
                .aggro(.medium, size: 15)
            }
            .padding(.leading, 10 + 82 + 16 + 16)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 16) {
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
                    
                Spacer()
                
                VStack(alignment: .leading, spacing: 16) {
                    KoreanPronsListView("AM", "오전", "OJEON")
                    KoreanPronsListView("PM", "오후", "OHU")
                    KoreanPronsListView("Hours", "시", "SI")
                    KoreanPronsListView("Minutes", "분", "BUN")
                    KoreanPronsListView("Seconds", "초", "CHO")
                }
                .frame(width: 240)
            }
            .padding(.trailing, 60)
        }
    }
}

#Preview {
    KoreanSheetView()
}
