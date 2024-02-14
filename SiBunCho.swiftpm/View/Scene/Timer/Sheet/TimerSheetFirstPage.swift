//
//  TimerSheetFirstPage.swift
//
//
//  Created by 남유성 on 2/14/24.
//

import SwiftUI

struct TimerSheetFirstPage: View {
    var body: some View {
        
        VStack(alignment: .leading, spacing: 48) {
            Text("How can express\nafter 1 hour?")
                .aggro(.bold, size: 32)
                .lineSpacing(8)
            
            Text("""
            How do you express after a certain period of time in Korean.

            When marking time intervals in Korea,
            hours, minutes, and seconds are marked
            in “시간”, “분”, and “초”, respectively.
            
            Also, ago an after are marked as “전” and “후”.
            """)
                .aggro(.light, size: 16)
            
            HStack(alignment: .top) {
                Spacer()
                VStack(alignment: .leading, spacing: 16) {
                    KoreanPronsListView("Hour", "시", "si")
                    KoreanPronsListView("Minute", "분", "bun")
                    KoreanPronsListView("Second", "초", "cho")
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 16) {
                    KoreanPronsListView("Ago", "전", "jeon")
                    KoreanPronsListView("After", "후", "hu")
                }
                Spacer()
            }
        }
        .frame(width: 580)
    }
}

#Preview {
    TimerSheetFirstPage()
}
