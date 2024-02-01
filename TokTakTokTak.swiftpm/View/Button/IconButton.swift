//
//  IconButton.swift
//  TokTakTokTak
//
//  Created by 남유성 on 2/1/24.
//

import SwiftUI

struct IconButton: View {
    
    @State private var isToggled: Bool = false
    
    private var name: String = ""
    private var nameForToggle: String?
    private var imgSize: CGFloat = 32
    private var content: String?

    private var action: () -> Void
    
    public init(
        _ name: String = "",
        _ nameForToggle: String? = nil,
        imgSize: CGFloat = 32,
        action: @escaping () -> Void) {
        
        self.name = name
        self.nameForToggle = nameForToggle
        self.imgSize = imgSize
        self.action = action
    }
    
    public init(
        text: String,
        action: @escaping () -> Void) {
        
        self.content = text
        self.action = action
    }
    
    public var body: some View {
        Button {
            action()
            isToggled.toggle()
        } label: {
            if let content = content {
                Text(content)
                    .font(.system(size: 32, weight: .thin))
                    .foregroundStyle(Color.primary)
            } else {
                Image(systemName: nameForToggle == nil ? name : isToggled ? nameForToggle! : name)
                    .font(.system(size: imgSize, weight: .thin))
                    .foregroundStyle(Color.primary)
            }
        }
        .frame(width: 48, height: 48)
    }
}
