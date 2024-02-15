//
//  KoreanPronsView.swift
//  
//
//  Created by 남유성 on 2/2/24.
//

import SwiftUI

struct KoreanPronsListView: View {
    
    private let text: String
    private let detail: String
    private let prons: String
    private let detail2: String?
    private let prons2: String?
    private let textWidth: CGFloat
    private let pronsWidth: CGFloat
    
    init(
        _ text: String,
        _ detail: String,
        _ prons: String,
        _ detail2: String? = nil,
        _ prons2: String? = nil,
        textWidth: CGFloat = 82,
        pronsWidth: CGFloat = 140
    ) {
        self.text = text
        self.detail = detail
        self.prons = prons
        self.detail2 = detail2
        self.prons2 = prons2
        self.textWidth = textWidth
        self.pronsWidth = pronsWidth
    }
    
    var body: some View {
        HStack {
            HStack {
                Spacer()
                Text(text)
            }
            .frame(width: textWidth)
            
            Rectangle()
                .frame(width: 1, height: 12)
                .background(Color.gray3)
                .padding([.leading, .trailing], 8)
            
            HStack {
                KoreanPronsView(text: detail, prons: prons)
                Spacer()
            }
            .frame(width: pronsWidth)
            
            if detail2 != nil && prons2 != nil {
                Text("/")
                    .aggro(.light, size: 17)
                KoreanPronsView(text: detail2!, prons: prons2!)
            }
        }
    }
}

struct KoreanPronsView: View {
    
    private let text: String
    private let prons: String
    
    init(text: String, prons: String) {
        self.text = text
        self.prons = prons
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 6) {
                Text(text)
                    .aggro(.light, size: 17)
                    .foregroundStyle(.primary)
                Text("[\(prons)]")
                    .aggro(.light, size: 15)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

