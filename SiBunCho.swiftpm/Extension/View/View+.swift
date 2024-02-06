//
//  File.swift
//  
//
//  Created by 남유성 on 2/3/24.
//

import SwiftUI

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
    
    func animatableSystemFont(weight: Aggro, size: Double) -> some View {
        self.modifier(AnimatableAggroFontModifier(weight: weight, size: size))
    }
}

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

struct AnimatableAggroFontModifier: ViewModifier, Animatable {
    var weight: Aggro
    var size: Double

    var animatableData: Double {
        get { size }
        set { size = newValue }
    }

    func body(content: Content) -> some View {
        content
            .aggro(weight, size: size)
    }
}
