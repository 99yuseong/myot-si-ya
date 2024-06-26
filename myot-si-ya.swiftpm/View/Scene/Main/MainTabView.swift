//
//  ContentView.swift
//  
//
//  Created by 남유성 on 2/4/24.
//

import SwiftUI
import Combine

struct MainTabView: View {
    @State private var isTabBarVisible: Bool = false
    @EnvironmentObject var appState: AppState
    @State private var timerCancellable: AnyCancellable?
    
    var body: some View {
        let binding = Binding<Int>(
            get: { self.appState.selectedTab },
            set: {
                self.appState.selectedTab = $0
                self.setTimer()
            }
        )
        
        return ZStack {
            TabView(selection: binding) {
                AboutMainView()
                    .tabItem {
                        Image(systemName: Icon.clock)
                            .font(.system(size: 32, weight: .thin))
                        Text("Clock")
                    }
                    .tag(0)
                    .toolbar(isTabBarVisible ? .visible : .hidden, for: .tabBar)
                
                AlarmMainView()
                    .tabItem {
                        Image(systemName: Icon.alarm)
                            .font(.system(size: 32, weight: .thin))
                        Text("Alarms")
                    }
                    .tag(1)
                    .toolbar(isTabBarVisible ? .visible : .hidden, for: .tabBar)
                
                TimerMainView()
                    .tabItem {
                        Image(systemName: Icon.timer)
                            .font(.system(size: 32, weight: .thin))
                        Text("Timers")
                    }
                    .tag(2)
                    .toolbar(isTabBarVisible ? .visible : .hidden, for: .tabBar)
            }
            .aggro(.light, size: 16)
            .onAppear() {
                let appearance = UITabBar.appearance()

                appearance.backgroundImage = UIImage()
                appearance.shadowImage = UIImage()
                appearance.clipsToBounds = true
            }

            if !isTabBarVisible {
                VStack {
                    Spacer()
                    Button {
                        withAnimation {
                            isTabBarVisible = true
                        }
                        setTimer()
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: Icon.chevronTop)
                                .font(.system(size: 40, weight: .thin))
                            Text("Show tab")
                                .aggro(.light, size: 15)
                        }
                        .padding()
                    }
                    .foregroundStyle(.secondary)
                    Spacer()
                        .frame(height: 24)
                }
            }
        }
        .edgesIgnoringSafeArea([.top, .leading, .trailing])
    }

    func setTimer() {
        timerCancellable?.cancel()
        
        timerCancellable = Timer.publish(every: 3, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                withAnimation {
                    self.isTabBarVisible = false
                }
            }
    }

}

#Preview {
    MainTabView()
}
