//
//  SplashView.swift
//
//
//  Created by 남유성 on 2/20/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Image("Logo")
                    .resizable()
                    .frame(width: 400, height: 400)
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
            Spacer()
        }
        .ignoresSafeArea()
        .background(Color.bg)
    }
}

#Preview {
    SplashView()
}
