import SwiftUI
import UIKit
import Combine

struct AboutMainView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var currentTime = Date()
    @State private var isMuted: Bool = true
    @State private var isTimerRunning: Bool = false
    @State private var isPresentingSheet: Bool = false
    @State private var isScreenMode: Bool = false
    @State private var isUpdatingBrightness: Bool = false
    @State private var isPortrait: Bool = false
    
    @State private var timerCancellable: AnyCancellable?
    @State private var mainTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var brightness: Double = Double(UIScreen.main.brightness)

    private let player = AudioService()
    

    var body: some View {
        ZStack {
            GeometryReader { gr in
                if gr.size.width < gr.size.height || isPortrait {
                    VStack {
                        if isScreenMode {
                            HStack {
                                AboutMainControlView(
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
                                AboutMainDetailView(
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
                            AboutMainClockView(
                                currentTime: $currentTime,
                                isTimerRunning: $isTimerRunning,
                                brightness: $brightness,
                                isMuted: $isMuted,
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
                                AboutMainControlView(
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
                                AboutMainDetailView(
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
                            AboutMainClockView(
                                currentTime: $currentTime,
                                isTimerRunning: $isTimerRunning,
                                brightness: $brightness,
                                isMuted: $isMuted,
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
            switch newOrientation {
            case .portrait, .portraitUpsideDown:
                isPortrait = true
            case .landscapeLeft, .landscapeRight:
                isPortrait = false
            default:
                break
            }
        }
    }
}
