//
//  Color+.swift
//
//
//  Created by 남유성 on 2/1/24.
//

import SwiftUI

extension Color {
    static let bg = Color("bg")
    static let gray1 = Color("gray1")
    static let gray2 = Color("gray2")
    static let gray3 = Color("gray3")
    static let gray4 = Color("gray4")
    static let gray5 = Color("gray5")
    static let quaternary = Color("quaternary")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
    
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
    
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}


