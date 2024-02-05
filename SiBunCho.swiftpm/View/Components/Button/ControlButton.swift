//
//  ControlButton.swift
//
//
//  Created by 남유성 on 2/5/24.
//

import SwiftUI

struct ControlButton: View {
    
    let icon: String
    let tintColor: Color = .secondary
    let bgColor: Color = .quaternaryDark
    let iconSize: CGFloat = 32
    let btnSize: CGSize = CGSize(width: 60, height: 60)
    let action: () -> Void
    
    init(icon: String, action: @escaping () -> Void) {
        self.icon = icon
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                
                Circle()
                    .frame(width: btnSize.width, height: btnSize.height)
                    .foregroundStyle(bgColor)
                
                Image(systemName: icon)
                    .font(.system(size: iconSize, weight: .regular))
                    .foregroundStyle(tintColor)
            }
        }
    }
}
