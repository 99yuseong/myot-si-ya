//
//  Font.swift
//
//
//  Created by 남유성 on 2/1/24.
//

import SwiftUI

enum Aggro: String {
    case bold = "SBAggroB"
    case light = "SBAggroL"
    case medium = "SBAggroM"
}

public struct FontManager {
    public static func registerFonts() {
        registerFont(bundle: Bundle.main, fontName: Aggro.bold.rawValue, fontExtension: ".ttf")
        registerFont(bundle: Bundle.main, fontName: Aggro.medium.rawValue, fontExtension: ".ttf")
        registerFont(bundle: Bundle.main, fontName: Aggro.light.rawValue, fontExtension: ".ttf")
    }
    
    fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
        
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from data")
        }
        
        var error: Unmanaged<CFError>?
        
        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}
