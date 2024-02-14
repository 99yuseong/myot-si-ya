//
//  AlarmSheetFirstPage.swift
//
//
//  Created by 남유성 on 2/13/24.
//

import SwiftUI

struct AlarmSheetFirstPage: View {
    
    let speechService: SpeechService
    
    init(_ speechService: SpeechService) {
        self.speechService = speechService
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("What time is 12 o'clock?")
                .aggro(.bold, size: 32)
            
            Spacer().frame(height: 32)
            
            VStack(alignment: .leading, spacing: -12) {
                Text("In Korea, it is usually marked")
                    .aggro(.light, size: 20)
                
                HStack(spacing: 4) {
                    Text("낮 12시 / 밤 12시")
                        .aggro(.bold, size: 32)
                    Text("[nat(bam)-yeol-du-si]")
                        .aggro(.light, size: 16)
                        .foregroundStyle(.tertiary)
                    Spacer()
                    IconButton(
                        Icon.sound,
                        contentSize: 40,
                        btnSize: CGSize(width: 80, height: 80)
                    ) {
                        speechService.speakInKorean("낮 12시, 밤 12시")
                    }
                }
                
                Text("to reduce confusion.")
                    .aggro(.light, size: 20)
            }
            
            Spacer().frame(height: 48)
            
            Text("""
            In Korean, Daytime and Night are “낮” and “밤”.

            We use expressions that distinguish
            between morning and afternoon to distinguish the exact time.

            Many expressions are also used in Korea to reduce confusion.
            This time, let's learn about time expressions.
            """)
            .aggro(.light, size: 16)
        }
        .frame(width: 600)
    }
}

#Preview {
    AlarmSheetFirstPage(SpeechService())
}
