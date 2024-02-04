//
//  VerticalSlider.swift
//  TokTakTokTak
//
//  Created by 남유성 on 2/2/24.
//

import SwiftUI

struct VerticalSlider: View {
    
    @Binding var value: Double
    var onChange: () -> Void
    var onEnd: () -> Void
    
    var body: some View {
        GeometryReader { gr in
            let thumbSize = gr.size.width
            let maxY = gr.size.height - thumbSize
            
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.quaternaryDark)
                    .frame(width: thumbSize, height: gr.size.height)
                
                
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: thumbSize, height: thumbSize + value * maxY)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { v in
                        let posY = maxY - v.location.y
                        value = max(0, min(maxY, posY)) / maxY
                        onChange()
                    }
                    .onEnded { v in
                        let posY = maxY - v.location.y
                        value = max(0, min(maxY, posY)) / maxY
                        onEnd()
                    }
            )
            
        }
    }
}
