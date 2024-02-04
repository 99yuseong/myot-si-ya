//
//  MainClockView.swift
//  TokTakTokTak
//
//  Created by 남유성 on 2/3/24.
//

import SwiftUI

struct AboutMainClockView: View {
    
    @Binding var currentTime: Date
    @Binding var isTimerRunning: Bool
    @Binding var brightness: Double
    @Binding var isMuted: Bool
    
    let player: AudioService
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .trailing, spacing: -18) {
            Text("\(currentTime.toKoreanAmPm())")
            HStack(spacing: 0) {
                VStack(alignment: .trailing, spacing: -18) {
                    Text("\(currentTime.toKoreanHours())")
                    Text("\(currentTime.toKoreanMinutes())")
                    Text("\(currentTime.toKoreanSeconds())")
                }
                VStack(alignment: .trailing, spacing: -18) {
                    Text("시")
                    Text("분")
                    Text("초")
                }
                .foregroundStyle(brightness < 0.2 ? .primary : .tertiary)
                .animation(.easeInOut, value: brightness)
            }
            .onReceive(timer) {
                currentTime = $0
                if !isTimerRunning {
                    player.playAudio(fileName: "clock1")
                    isMuted ? player.mute() : player.unmute()
                    isTimerRunning.toggle()
                }
            }
        }
        .aggro(.bold, size: 130)
        .foregroundColor(.primary)
    }
}
