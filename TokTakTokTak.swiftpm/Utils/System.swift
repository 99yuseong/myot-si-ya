//
//  System.swift
//  TokTakTokTak
//
//  Created by 남유성 on 2/1/24.
//

import Foundation

class System {
    static let shared = System()
    
    private init() {}
    
    func log(_ text: String) {
        print("-----------------------------------------------------")
        print("[System]: \(text)")
        print(#fileID)
        print(#function)
        print(#line)
        print("-----------------------------------------------------")
    }
}
