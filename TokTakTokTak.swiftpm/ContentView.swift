import SwiftUI
import UIKit
import Combine

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var currentTime = Date()
    @State private var isTimerRunning: Bool = false
    @State private var isPresentingSheet = false
    @State private var isScreenMode = false
    @State private var isUpdatingBrightness: Bool = false
    
    @State private var brightness: Double = Double(UIScreen.main.brightness)
    @State private var timerCancellable: AnyCancellable?

    private let player = AudioService()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        HStack {
            if isScreenMode {
                VStack {
                    Spacer()
                    VStack {
                        HStack {
                            Spacer()
                            if isUpdatingBrightness {
                                VerticalSlider(
                                    value: $brightness,
                                    onChange: {
                                        timerCancellable?.cancel()
                                        UIScreen.main.brightness = CGFloat(brightness)
                                    },
                                    onEnd: {
                                        setTimer()
                                    }
                                )
                                    .frame(width: 40, height: 340)
                                    .transition(.opacity)
                            }
                            Spacer()
                                .frame(width: 4)
                        }
                        
                        Spacer()
                            .frame(height: 28)
                        
                        HStack(spacing: 16) {
                            IconButton(Icon.originalSize) {
                                withAnimation {
                                    isScreenMode = false
                                    isUpdatingBrightness = false
                                    UIApplication.shared.isIdleTimerDisabled = false
                                }
                            }
                            .animation(.easeInOut, value: brightness)
                            .foregroundStyle(brightness < 0.2 ? .primary : .tertiary)
                            
                            IconButton(Icon.brightness) {
                                withAnimation {
                                    isUpdatingBrightness.toggle()
                                }
                                setTimer()
                            }
                            .animation(.easeInOut, value: brightness)
                            .foregroundStyle(isUpdatingBrightness || brightness < 0.2 ? .primary : .tertiary)
                        }
                        .transition(.opacity)
                    }
                    .frame(width: 112, alignment: .trailing)
                    .padding([.leading, .bottom], 100)
                }
            } else {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("\"똑딱똑딱\" : Hangeul Clock")
                            .aggro(.bold, size: 24)
                        Text("is a clock app that marks\nthe current time in Korean.")
                            .aggro(.light, size: 17)
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("똑딱똑딱")
                                .aggro(.medium, size: 15)
                            Text("[ttok ttak ttok ttak]")
                                .foregroundStyle(.tertiary)
                        }
                        Text("is an onomatopoeic words\n of the clock ticking sound.")
                    }
                    .aggro(.light, size: 15)
                    
                    VStack(alignment: .leading) {
                        Text("current time is")
                            .aggro(.light, size: 17)
                        Text(currentTime.toFormat("h:mm:ss a"))
                            .aggro(.medium, size: 20)
                    }
                    
                    HStack(spacing: 16) {
                        IconButton(Icon.sound, Icon.soundOff) {
                            player.toggleSound()
                        }
                        IconButton(Icon.fullSize) {
                            withAnimation {
                                isScreenMode = true
                                UIApplication.shared.isIdleTimerDisabled = true
                            }
                        }
                        IconButton(text: "Aa") {
                            isPresentingSheet = true
                        }
                        .sheet(isPresented: $isPresentingSheet) {
                            KoreanSheetView()
                        }
                    }
                    .foregroundStyle(.primary)
                    Spacer()
                }
                .padding(.top, 100)
                .padding(.leading, 100)
                .transition(.opacity)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: -18) {
                Spacer()
                Text("\(currentTime.toKoreanAmPm())")
                HStack(spacing: 0) {
                    VStack(alignment: .trailing, spacing: -18) {
                        Text("\(currentTime.toKoreanHours())")
                        Text("\(currentTime.toKoreanMinutes())")
                        Text("\(currentTime.toKoreanSeconds())")
                    }
                    VStack(alignment: .trailing, spacing: -18) {
                        Text("시")
                        Text("분")
                        Text("초")
                    }
                    .foregroundStyle(brightness < 0.2 ? .primary : .tertiary)
                    .animation(.easeInOut, value: brightness)
                }
                .onReceive(timer) {
                    currentTime = $0
                    if !isTimerRunning {
                        player.playAudio(fileName: "clock1")
                        isTimerRunning.toggle()
                    }
                }
            }
            .aggro(.bold, size: 130)
            .foregroundColor(.primary)
            .padding(.bottom, 100)
            .padding(.trailing, 100)
        }
        .background(colorScheme == .light ? Color.bgLight : Color.bgDark)
    }
    
    func setTimer() {
        timerCancellable?.cancel()
        
        timerCancellable = Timer.publish(every: 2, on: .main, in: .common)
                            .autoconnect()
                            .sink { _ in
                                withAnimation {
                                    self.isUpdatingBrightness = false
                                }
                            }
    }
}
