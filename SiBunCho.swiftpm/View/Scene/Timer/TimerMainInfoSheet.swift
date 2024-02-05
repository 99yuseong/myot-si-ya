//
//  TimerMainInfoSheet.swift
//
//
//  Created by 남유성 on 2/5/24.
//

import SwiftUI

struct TimerMainInfoSheet: View {
    
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int
    @Binding var selectedSecond: Int
    
    private let speechService = SpeechService()
    private let date = Date()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 0) {
                    Text("\(selectedHour)")
                    Text("h ")
                        .foregroundStyle(.secondary)
                    Text("\(selectedMinute)")
                    Text("m ")
                        .foregroundStyle(.secondary)
                    Text("\(selectedSecond)")
                    Text("s")
                        .foregroundStyle(.secondary)
                }
                
                HStack(spacing: 0) {
                    Text("\(selectedHour)")
                    Text("시간 ")
                        .foregroundStyle(.secondary)
                    Text("\(selectedMinute)")
                    Text("분 ")
                        .foregroundStyle(.secondary)
                    Text("\(selectedSecond)")
                    Text("초")
                        .foregroundStyle(.secondary)
                }
            }
            .aggro(.bold, size: 36)
            Spacer()
            IconButton(
                Icon.sound,
                contentSize: 40,
                btnSize: CGSize(width: 80, height: 80)
            ) {
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
                    KoreanPronsListView("Hour", "시간", "SIGAN")
                    KoreanPronsListView("Minute", "분", "BUN")
                    KoreanPronsListView("Second", "초", "CHO")
                }
                .frame(width: 240)
            }
            .padding(.trailing, 60)
        }
    }
}
