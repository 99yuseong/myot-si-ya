import SwiftUI
import UIKit
import Combine

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var currentTime = Date()
    @State private var isMuted: Bool = false
    @State private var isTimerRunning: Bool = false
    @State private var isPresentingSheet: Bool = false
    @State private var isScreenMode: Bool = false
    @State private var isUpdatingBrightness: Bool = false
    @State private var isPortrait: Bool = false
    
    @State private var timerCancellable: AnyCancellable?
    
    @State private var brightness: Double = Double(UIScreen.main.brightness)

    private let player = AudioService()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            GeometryReader { gr in
                if gr.size.width < gr.size.height || isPortrait {
                    VStack {
                        if isScreenMode {
                            HStack {
                                MainControlView(
                                    isScreenMode: $isScreenMode,
                                    isUpdatingBrightness: $isUpdatingBrightness,
                                    brightness: $brightness,
                                    timerCancellable: $timerCancellable,
                                    isPortrait: $isPortrait
                                )
                                .padding([.top, .leading, .bottom], 100)
                                Spacer()
                            }
                        } else {
                            HStack {
                                MainDetailView(
                                    currentTime: $currentTime,
                                    isScreenMode: $isScreenMode,
                                    isPresentingSheet: $isPresentingSheet,
                                    isMuted: $isMuted,
                                    player: player
                                )
                                .padding([.top, .leading], 100)
                                Spacer()
                            }
                        }
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            MainClockView(
                                currentTime: $currentTime,
                                isTimerRunning: $isTimerRunning,
                                brightness: $brightness,
                                player: player
                            )
                            .padding([.bottom, .trailing], 100)
                        }
                    }
                } else {
                    HStack {
                        if isScreenMode {
                            VStack {
                                Spacer()
                                MainControlView(
                                    isScreenMode: $isScreenMode,
                                    isUpdatingBrightness: $isUpdatingBrightness,
                                    brightness: $brightness,
                                    timerCancellable: $timerCancellable,
                                    isPortrait: $isPortrait
                                )
                                .padding([.leading, .bottom], 100)
                            }
                        } else {
                            VStack {
                                MainDetailView(
                                    currentTime: $currentTime,
                                    isScreenMode: $isScreenMode,
                                    isPresentingSheet: $isPresentingSheet,
                                    isMuted: $isMuted,
                                    player: player
                                )
                                .padding([.top, .leading], 100)
                                Spacer()
                            }
                        }
                        
                        Spacer()
                        
                        VStack {
                            Spacer()
                            MainClockView(
                                currentTime: $currentTime,
                                isTimerRunning: $isTimerRunning,
                                brightness: $brightness,
                                player: player
                            )
                            .padding([.top, .bottom, .trailing], 100)
                        }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .background(colorScheme == .light ? Color.bgLight : Color.bgDark)
        .onRotate { newOrientation in
            isPortrait = newOrientation.isPortrait
        }
    }
}
