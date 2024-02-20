//
//  UIPickerView+.swift
//
//
//  Created by 남유성 on 2/5/24.
//

import UIKit

extension UIPickerView {
    open override var intrinsicContentSize: CGSize {
        guard let picker = self as? CustomUIPickerView else { return .zero }
        switch picker.type {
        case .large:
            return CGSize(width: 228, height: 84 * 5)
        case .small:
            return CGSize(width: 138, height: 48 * 5)
        }
    }
}
