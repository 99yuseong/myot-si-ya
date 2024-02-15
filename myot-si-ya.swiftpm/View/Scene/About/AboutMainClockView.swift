//
//  MainClockView.swift
//  TokTakTokTak
//
//  Created by 남유성 on 2/3/24.
//

import SwiftUI

struct AboutMainClockView: View {
    
    @Binding var currentTime: Date
    @Binding var brightness: Double
    @Binding var isMuted: Bool
    
    @State var timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    let player: AudioService
    
    var body: some View {
        VStack(alignment: .trailing, spacing: -24) {
            Text("\(currentTime.toKoreanAmPm())")
            HStack(spacing: 0) {
                VStack(alignment: .trailing, spacing: -24) {
                    Text(hour())
                    Text(minute())
                    Text(second())
                }
                VStack(alignment: .trailing, spacing: -24) {
                    Text("시")
                    Text("분")
                    Text("초")
                }
                .foregroundStyle(brightness < 0.2 ? .primary : .tertiary)
                .animation(.easeInOut, value: brightness)
            }
            .onReceive(timer) {
                currentTime = $0
                if !isMuted {
                    player.playAudio(fileName: "clock",playCount: 1)
                }
            }
        }
        .aggro(.bold, size: 130)
        .foregroundColor(.primary)
    }
    
    fileprivate func hour() -> String {
        let hour = Calendar.current.component(.hour, from: currentTime)
        
        if hour == 0 {
            return "열두"
        }
        
        return currentTime.toKoreanHours()
    }
    
    fileprivate func minute() -> String {
        currentTime.toKoreanMinutes()
    }
    
    fileprivate func second() -> String {
        currentTime.toKoreanSeconds()
    }
}
