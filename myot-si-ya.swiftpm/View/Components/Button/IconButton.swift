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
    private var contentSize: CGFloat
    private var btnSize: CGSize
    private var content: String?

    private var action: () -> Void
    
    public init(
        _ name: String = "",
        _ nameForToggle: String? = nil,
        contentSize: CGFloat = 32,
        btnSize: CGSize = CGSize(width: 48, height: 48),
        action: @escaping () -> Void) {
        
        self.name = name
        self.nameForToggle = nameForToggle
        self.contentSize = contentSize
        self.btnSize = btnSize
        self.action = action
    }
    
    public init(
        text: String,
        contentSize: CGFloat = 32,
        btnSize: CGSize = CGSize(width: 48, height: 48),
        action: @escaping () -> Void) {
        
        self.content = text
        self.contentSize = contentSize
        self.btnSize = btnSize
        self.action = action
    }
    
    public var body: some View {
        Button {
            action()
            isToggled.toggle()
        } label: {
            if let content = content {
                Text(content)
                    .font(.system(size: contentSize, weight: .thin))
                    .frame(width: btnSize.width, height: btnSize.height)
            } else {
                Image(systemName: nameForToggle == nil ? name : isToggled ? nameForToggle! : name)
                    .font(.system(size: contentSize, weight: .thin))
                    .frame(width: btnSize.width, height: btnSize.height)
            }
        }
    }
}
