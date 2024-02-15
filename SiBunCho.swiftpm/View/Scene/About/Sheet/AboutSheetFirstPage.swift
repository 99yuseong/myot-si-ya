//
//  AboutSheetFirstPage.swift
//
//
//  Created by 남유성 on 2/13/24.
//

import SwiftUI

struct AboutSheetFirstPage: View {
    
    let speechService: SpeechService
    
    init(_ speechService: SpeechService) {
        self.speechService = speechService
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("What time is it?")
                .aggro(.bold, size: 32)
            
            Spacer().frame(height: 32)
            
            VStack(alignment: .leading, spacing: -12) {
                Text("In korean, you can say")
                    .aggro(.light, size: 20)
                
                HStack(spacing: 4) {
                    Text("몇시야?")
                        .aggro(.bold, size: 32)
                    Text("[myot-si-ya]")
                        .aggro(.light, size: 16)
                        .foregroundStyle(.tertiary)
                    Spacer()
                    IconButton(
                        Icon.sound,
                        contentSize: 40,
                        btnSize: CGSize(width: 80, height: 80)
                    ) {
                        speechService.speakInKorean("몇시야?")
                    }
                }
            }
            
            Spacer().frame(height: 48)
            
            Text("""
            To answer this question,
            we need to know Korean time expressions.

            Korean time expression is a little unusual.
            There are Sino Korean and native Korean expressions.
            We use both expressions to indicate time.

            Usually, native korean is used for hour,
            sino korean is used for minute and second.
            """)
            .aggro(.light, size: 16)
        }
        .frame(width: 480)
    }
}
