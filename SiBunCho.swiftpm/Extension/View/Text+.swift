//
//  Text+.swift
//
//
//  Created by 남유성 on 2/1/24.
//

import SwiftUI

extension View {
    func aggro(_ name: Aggro, size: CGFloat) -> some View {
        self.modifier(FontModifier(name: name.rawValue, size: size))
    }
}

struct FontModifier: ViewModifier {
    var name: String
    var size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.custom(name, size: size))
    }
}
