//
//  myot_si_yaApp.swift
//  myot-si-ya
//
//  Created by 남유성 on 3/2/24.
//

import SwiftUI

@main
struct myot_si_yaApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var appState = AppState.shared
    @State var isLaunching: Bool = true
    
    init() {
        FontManager.registerFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            if isLaunching {
                SplashView()
                    .preferredColorScheme(.dark)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                isLaunching = false
                            }
                        }
                    }
            } else {
                MainTabView()
                    .environmentObject(appState)
                    .preferredColorScheme(.dark)
            }
        }
    }
}

class AppState: ObservableObject {
    static let shared = AppState()
    
    @Published var selectedTab = 0
}
