//
//  HorizontalSlider.swift
//
//
//  Created by 남유성 on 2/3/24.
//

import SwiftUI

struct HorizontalSlider: View {
    
    @Binding var value: Double
    var onChange: () -> Void
    var onEnd: () -> Void
    
    var body: some View {
        GeometryReader { gr in
            let thumbSize = gr.size.height
            let maxX = gr.size.width - thumbSize
            
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.quaternary)
                    .frame(width: gr.size.height, height: thumbSize)
                
                
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: thumbSize + value * maxX, height: thumbSize)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { v in
                        let posX = v.location.x
                        value = max(0, min(maxX, posX)) / maxX
                        onChange()
                    }
                    .onEnded { v in
                        let posX = v.location.x
                        value = max(0, min(maxX, posX)) / maxX
                        onEnd()
                    }
            )
            
        }
    }
}

