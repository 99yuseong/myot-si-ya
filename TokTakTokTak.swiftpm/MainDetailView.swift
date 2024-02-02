//
//  MainDetailView.swift
//  TokTakTokTak
//
//  Created by 남유성 on 2/3/24.
//

import SwiftUI

struct MainDetailView: View {
    
    @Binding var currentTime: Date
    @Binding var isScreenMode: Bool
    @Binding var isPresentingSheet: Bool
    @Binding var isMuted: Bool
    
    let player: AudioService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text("\"똑딱똑딱\" : Hangeul Clock")
                    .aggro(.bold, size: 24)
                Text("is a clock app that marks\nthe current time in Korean.")
                    .aggro(.light, size: 17)
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text("똑딱똑딱")
                        .aggro(.medium, size: 15)
                    Text("[ttok ttak ttok ttak]")
                        .foregroundStyle(.tertiary)
                }
                Text("is an onomatopoeic words\n of the clock ticking sound.")
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
                        isMuted.toggle()
                        player.toggleSound()
                    }
                } else {
                    IconButton(Icon.sound) {
                        isMuted.toggle()
                        player.toggleSound()
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
                .sheet(isPresented: $isPresentingSheet) {
                    KoreanSheetView()
                }
            }
            .foregroundStyle(.primary)
        }
        .transition(.opacity)
    }
}
