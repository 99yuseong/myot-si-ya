//
//  ClearBgView.swift
//
//
//  Created by 남유성 on 2/13/24.
//

import SwiftUI

struct ClearBgView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
