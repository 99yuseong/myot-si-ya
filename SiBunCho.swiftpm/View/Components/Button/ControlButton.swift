//
//  ControlButton.swift
//
//
//  Created by 남유성 on 2/5/24.
//

import SwiftUI

struct ControlButton: View {
    
    @State var isToggled: Bool = false
    
    let icon: String
    let toggleIcon: String?
    let tintColor: Color = .secondary
    let bgColor: Color = .quaternaryDark
    let iconSize: CGFloat = 32
    let btnSize: CGSize = CGSize(width: 60, height: 60)
    let action: () -> Void
    
    init(icon: String, toggleIcon: String? = nil, action: @escaping () -> Void) {
        self.icon = icon
        self.toggleIcon = toggleIcon
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
            if toggleIcon != nil {
                isToggled.toggle()
            }
        } label: {
            Image(systemName: (toggleIcon == nil || !isToggled) ? icon : toggleIcon!)
                .font(.system(size: iconSize, weight: .regular))
                .foregroundStyle(tintColor)
        }
        .frame(width: btnSize.width, height: btnSize.height)
        .background(bgColor)
        .clipShape(Circle())
    }
}
