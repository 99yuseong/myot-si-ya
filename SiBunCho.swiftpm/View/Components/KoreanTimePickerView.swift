//
//  KoreanTimePickerView.swift
//
//
//  Created by 남유성 on 2/5/24.
//

import SwiftUI

enum PickerType {
    case large
    case small
    
    var fontSize: CGFloat {
        switch self {
        case .small: return 40
        case .large: return 70
        }
    }
    
    var height: CGFloat {
        switch self {
        case .small: return 48
        case .large: return 84
        }
    }
}

struct KoreanTimePickerView: UIViewRepresentable {
    
    @Binding var selectedItem: Int
    @State var section = 1000
    @State var lastSelectedRow = 0
    
    let items: [Int]
    let isNative: Bool
    let type: PickerType
    
    func makeUIView(context: Context) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.dataSource = context.coordinator
        pickerView.delegate = context.coordinator
        return pickerView
    }
    
    func updateUIView(_ pickerView: UIPickerView, context: Context) {
        pickerView.selectRow(selectedItem + section * items.count, inComponent: 0, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        var parent: KoreanTimePickerView
        
        init(_ pickerView: KoreanTimePickerView) {
            self.parent = pickerView
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return parent.items.count * 10000
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            let actualRow = row % parent.items.count
            
            if parent.isNative {
                return "\(parent.items[actualRow].nativeKoreanTime!)"
            }
            
            return "\(parent.items[actualRow].sinoKoreanTime!)"
        }
        
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            
            let actualRow = row % parent.items.count
            let label: UILabel
                        
            if let view = view as? UILabel {
                label = view
            } else {
                label = UILabel()
            }
            
            pickerView.subviews.forEach {
                $0.backgroundColor = .clear
                $0.alpha = 1
            }
                        
            if parent.isNative {
                label.text = "\(parent.items[actualRow].nativeKoreanTime!)"
            } else {
                label.text = "\(parent.items[actualRow].sinoKoreanTime!)"
            }
            label.textColor = .white
            label.textAlignment = .right
            label.font = UIFont(name: Aggro.bold.rawValue, size: parent.type.fontSize)
            label.backgroundColor = .clear
                        
            return label
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let actualRow = row % parent.items.count
            let lastSection = parent.lastSelectedRow / parent.items.count
            let curSection = row / parent.items.count
            
            if row > parent.lastSelectedRow { // down
                if lastSection != curSection {
                    parent.section = curSection
                }
            } else if row < parent.lastSelectedRow { // up
                if lastSection != curSection {
                    parent.section -= abs(lastSection - curSection)
                }
            }
            parent.lastSelectedRow = row
            parent.selectedItem = actualRow
        }
        
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return parent.type.height
        }
    }
}
