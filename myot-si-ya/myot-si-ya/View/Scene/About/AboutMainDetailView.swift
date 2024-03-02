//
//  MainDetailView.swift
//  TokTakTokTak
//
//  Created by 남유성 on 2/3/24.
//

import SwiftUI

struct AboutMainDetailView: View {
    
    @Binding var currentTime: Date
    @Binding var isScreenMode: Bool
    @Binding var isPresentingSheet: Bool
    @Binding var isMuted: Bool
    
    let player: AudioService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Hangeul Clock: 몇시야?")
                    .aggro(.bold, size: 32)
                Text("is a Hangeul clock app that marks\nthe current time in Korean.")
                    .aggro(.light, size: 17)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("몇시야?")
                        .aggro(.medium, size: 15)
                    Text("[myot-si-ya]")
                        .foregroundStyle(.tertiary)
                }
                Text("means what time is it?\nIt is a phrase in Korean asking for the exact time.")
            }
            .aggro(.light, size: 15)
            
            VStack(alignment: .leading) {
                Text("current time is")
                    .aggro(.light, size: 17)
                Text(currentTime.toFormat("h:mm:ss a"))
                    .aggro(.medium, size: 20)
            }
            
            HStack(spacing: 16) {
                if isMuted {
                    IconButton(Icon.soundOff) {
                        isMuted = false
                        player.unmute()
                    }
                } else {
                    IconButton(Icon.sound) {
                        isMuted = true
                        player.mute()
                    }
                }
                IconButton(Icon.fullSize) {
                    withAnimation {
                        isScreenMode = true
                        UIApplication.shared.isIdleTimerDisabled = true
                    }
                }
                IconButton(text: "Aa") {
                    isPresentingSheet = true
                }
                .fullScreenCover(isPresented: $isPresentingSheet) {
                    AboutMainInfoSheet()
                        .clearBg()
                }
            }
            .foregroundStyle(.primary)
        }
        .transition(.opacity)
    }
}
