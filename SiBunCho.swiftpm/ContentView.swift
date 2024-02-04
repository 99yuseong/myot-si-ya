//
//  ContentView.swift
//  SiBunCho
//
//  Created by 남유성 on 2/4/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var isTabBarVisible: Bool = false
    @State private var selectedTab = 3
    @State private var timerCancellable: AnyCancellable?
    
    var body: some View {
        let binding = Binding<Int>(
            get: { self.selectedTab },
            set: {
                self.selectedTab = $0
                self.setTimer()
            }
        )
        
        return ZStack {
            TabView(selection: binding) {
                AboutMainView()
                    .tabItem {
                        Image(systemName: Icon.about)
                            .font(.system(size: 32, weight: .thin))
                        Text("About")
                    }
                    .tag(0)
                    .toolbar(isTabBarVisible ? .visible : .hidden, for: .tabBar)
                
                Text("두 번째 탭")
                    .tabItem {
                        Image(systemName: Icon.global)
                            .font(.system(size: 32, weight: .thin))
                        Text("World Clock")
                    }
                    .tag(1)
                    .toolbar(isTabBarVisible ? .visible : .hidden, for: .tabBar)
                
                Text("세 번째 탭")
                    .tabItem {
                        Image(systemName: Icon.stopWatch)
                            .font(.system(size: 32, weight: .thin))
                        Text("StopWatch")
                    }
                    .tag(2)
                    .toolbar(isTabBarVisible ? .visible : .hidden, for: .tabBar)
                
                TimerMainView()
                    .tabItem {
                        Image(systemName: Icon.timer)
                            .font(.system(size: 32, weight: .thin))
                        Text("Timers")
                    }
                    .tag(3)
                    .toolbar(isTabBarVisible ? .visible : .hidden, for: .tabBar)
                
                Text("세 번째 탭")
                    .tabItem {
                        Image(systemName: Icon.alarm)
                            .font(.system(size: 32, weight: .thin))
                        Text("Alarms")
                    }
                    .tag(4)
                    .toolbar(isTabBarVisible ? .visible : .hidden, for: .tabBar)
            }
            .aggro(.light, size: 16)
            .tint(.primary)
            
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
        .ignoresSafeArea()
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
    ContentView()
}
