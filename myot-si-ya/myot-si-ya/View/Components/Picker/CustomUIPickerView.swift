//
//  CustomUIPickerView.swift
//
//
//  Created by 남유성 on 2/5/24.
//

import UIKit

class CustomUIPickerView: UIPickerView {
    
    let type: PickerType
    
    init(type: PickerType) {
        self.type = type
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
