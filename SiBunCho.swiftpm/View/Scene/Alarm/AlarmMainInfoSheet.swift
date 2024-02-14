//
//  AlarmMainInfoSheet.swift
//
//
//  Created by 남유성 on 2/13/24.
//

import SwiftUI

struct AlarmMainInfoSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var date: Date = Date()
    @State private var offset: CGSize = .zero
    @State private var alpha: Double = 1.0
    
    private let speechService = SpeechService()
    private let dThreshold: Double = 200
    private let vThreshold: Double = 200
    
    var body: some View {
        GeometryReader { gr in
            TabView {
                AlarmSheetFirstPage(speechService)
                AlarmSheetSecondPage(speechService: speechService)
                AlarmSheetThirdPage()
            }
            .tabViewStyle(.page)
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged { v in
                        let dy = v.location.y - v.startLocation.y
                        let y = v.translation.height
                        
                        if dy > 0 {
                            offset = CGSize(width: 0, height: y)
                            alpha = dThreshold / (abs(y) * 2.0)
                        }
                    }
                    .onEnded { v in
                        let dy = v.location.y - v.startLocation.y
                        let vy = v.velocity.height
                        
                        if dy > dThreshold || vy > vThreshold {
                            dismiss()
                        } else {
                            withAnimation {
                                offset = .zero
                                alpha = 1.0
                            }
                        }
                    }
            )
            .background(Color.bg)
            .opacity(alpha)
            .ignoresSafeArea()
        }
    }
}
