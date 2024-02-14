//
//  AlarmSheetThirdPage.swift
//
//
//  Created by 남유성 on 2/13/24.
//

import SwiftUI

struct AlarmSheetThirdPage: View {
    var body: some View {
        VStack(spacing: 48) {
            
            Text("""
            Instead of AM and PM,
            we can use expressions in front of the time to reduce confusion in time.
            
            You can check the time zone expressions in the table below. In addition, we use the expression “정오” at noon and “자정” at midnight.
            """)
                .aggro(.light, size: 16)
            
            GeometryReader { gr in
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ForEach(0..<24) {
                            Text("\($0)")
                                .aggro(.light, size: 15)
                                .frame(width: gr.size.width / 24)
                        }
                    }
                    
                    HStack(spacing: 0) {
                        Text("밤")
                            .frame(width: gr.size.width / 8, height: 66)
                            .background(Color.gray2)
                        Text("새벽")
                            .frame(width: gr.size.width / 8, height: 66)
                            .background(Color.gray3)
                        Text("아침")
                            .frame(width: gr.size.width / 4, height: 66)
                            .background(Color.gray4)
                        Text("낮")
                            .frame(width: gr.size.width / 4, height: 66)
                            .background(Color.gray2)
                        Text("저녁")
                            .frame(width: gr.size.width / 8, height: 66)
                            .background(Color.gray3)
                        Text("밤")
                            .frame(width: gr.size.width / 8, height: 66)
                            .background(Color.gray4)
                    }
                    
                    HStack(spacing: 0) {
                        Text("오전")
                            .frame(width: gr.size.width / 2, height: 66)
                            .background(Color.gray1)
                        Text("오후")
                            .frame(width: gr.size.width / 2, height: 66)
                            .background(Color.gray5)
                    }
                }
                .aggro(.light, size: 16)
            }
            .frame(height: 18 + 66 + 66)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 16) {
                    KoreanPronsListView("AM", "오전", "o-jeon")
                    KoreanPronsListView("Dawn", "새벽", "sae-byeok", pronsWidth: 160)
                    KoreanPronsListView("Morning", "아침", "a-chim")
                    KoreanPronsListView("Noon", "정오", "jeong-o")
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 16) {
                    KoreanPronsListView("PM", "오후", "o-hu")
                    KoreanPronsListView("Daytime", "낮", "nat")
                    KoreanPronsListView("Evening", "저녁", "jeo-nyeok", pronsWidth: 160)
                    KoreanPronsListView("Night", "밤", "bam")
                    KoreanPronsListView("Midnight", "자정", "ja-jeong")
                }
            }
        }
        .frame(width: 640)
    }
}

#Preview {
    AlarmSheetThirdPage()
}
