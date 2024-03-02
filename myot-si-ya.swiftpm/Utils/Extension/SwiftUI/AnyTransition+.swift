//
//  AnyTransition+.swift
//
//
//  Created by 남유성 on 2/14/24.
//

import SwiftUI

extension AnyTransition {
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))
    }
}
