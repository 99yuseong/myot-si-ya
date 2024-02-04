//
//  MainControlView.swift
//  TokTakTokTak
//
//  Created by 남유성 on 2/3/24.
//

import SwiftUI
import Combine

struct AboutMainControlView: View {
    
    @Binding var isScreenMode: Bool
    @Binding var isUpdatingBrightness: Bool
    @Binding var brightness: Double
    
    @Binding var timerCancellable: AnyCancellable?
    
    @Binding var isPortrait: Bool
    
    var body: some View {
        if isPortrait {
            HStack(spacing: 16) {
                IconButton(Icon.originalSize) {
                    withAnimation {
                        isScreenMode = false
                    }
                    isUpdatingBrightness = false
                    UIApplication.shared.isIdleTimerDisabled = false
                }
                .animation(.easeInOut, value: brightness)
                .foregroundStyle(brightness < 0.2 ? .primary : .tertiary)
                    
                IconButton(Icon.brightness) {
                    if isUpdatingBrightness {
                        isUpdatingBrightness = false
                        //                                    timerCancellable?.cancel()
                    } else {
                        isUpdatingBrightness = true
                        setTimer()
                    }
                }
                .animation(.easeInOut, value: brightness)
                .foregroundStyle(isUpdatingBrightness || brightness < 0.2 ? .primary : .tertiary)
                
                if isUpdatingBrightness {
                    VStack {
                        HorizontalSlider(
                            value: $brightness,
                            onChange: {
                                timerCancellable?.cancel()
                                UIScreen.main.brightness = CGFloat(brightness)
                            },
                            onEnd: {
                                setTimer()
                            }
                        )
                        .frame(width: 340, height: 40)
                        .transition(.opacity)
                    }
                }
            }
            .transition(.opacity)
        } else {
            VStack {
                if isUpdatingBrightness {
                    HStack {
                        Spacer()
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
                        
                        Spacer()
                            .frame(width: 4)
                    }
                    
                    Spacer()
                        .frame(height: 28)
                }
                    
                HStack(spacing: 16) {
                    IconButton(Icon.originalSize) {
                        withAnimation {
                            isScreenMode = false
                        }
                        isUpdatingBrightness = false
                        UIApplication.shared.isIdleTimerDisabled = false
                    }
                    .animation(.easeInOut, value: brightness)
                    .foregroundStyle(brightness < 0.2 ? .primary : .tertiary)
                        
                    IconButton(Icon.brightness) {
                        withAnimation {
                            if isUpdatingBrightness {
                                isUpdatingBrightness = false
                                //                                    timerCancellable?.cancel()
                            } else {
                                isUpdatingBrightness = true
                                setTimer()
                            }
                        }
                    }
                    .animation(.easeInOut, value: brightness)
                    .foregroundStyle(isUpdatingBrightness || brightness < 0.2 ? .primary : .tertiary)
                }
                .transition(.opacity)
            }
            .frame(width: 112, alignment: .trailing)
        }
    }
    
    func setTimer() {
        timerCancellable?.cancel()
        
        timerCancellable = Timer.publish(every: 3, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                withAnimation {
                    self.isUpdatingBrightness = false
                }
            }
    }
}
