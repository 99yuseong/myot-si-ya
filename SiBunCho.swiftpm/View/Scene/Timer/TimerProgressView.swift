//
//  SwiftUIView.swift
//  
//
//  Created by 남유성 on 2/5/24.
//

import SwiftUI
import Combine

struct TimerProgressView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    @State private var timerCancellable: Cancellable? = nil
    @State var isTimerRunning = false
    @State var isPaused = false
    
    @Binding var remainingTime: Int
    @Binding var totalTime: Int
    @Binding var isLinkActive: Bool
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        HStack(spacing: 32) {
                            ControlButton(icon: Icon.cancel) {
                                dismiss.callAsFunction()
                            }
                            
                            ControlButton(icon: Icon.pause, toggleIcon: Icon.play) {
                                if !isPaused {
                                    timerCancellable?.cancel()
                                } else {
                                    setTimer()
                                }
                                isPaused.toggle()
                            }
                        }
                    }
                    .padding([.leading, .bottom, .trailing], 100)
                }
                
                ProgressView(value: Double(remainingTime) / Double(totalTime))
                    .progressViewStyle(CircularProgressViewStyle(size: 560))
                    .animation(.linear(duration: 1), value: remainingTime)
                
                HStack {
                    Spacer()
                    VStack(alignment: .trailing, spacing: -12) {
                        Text(hour().nativeKoreanTime! + "시간")
                            .foregroundStyle(hour() > 0 ? .primary : .quinary)
                            .opacity(hour() > 0 ? 1 : 0.5)
                        Text(minute().sinoKoreanTime! + "분")
                            .foregroundStyle(hour() > 0 ? .tertiary : minute() > 0 ? . primary : .quinary)
                            .opacity(minute() > 0 ? 1 : 0.5)
                        Text(second().sinoKoreanTime! + "초")
                            .foregroundStyle(hour() > 0 ? .quaternary : minute() > 0 ? . tertiary : .primary)
                    }
                }
                .frame(width: 384 + 8)
                .aggro(.bold, size: 100)
            }
            
            
        }
        .ignoresSafeArea()
        .background(colorScheme == .light ? Color.bgLight : Color.bgDark)
        .onAppear {
            if !isTimerRunning {
                setTimer()
                isTimerRunning = true
            }
        }
        .onDisappear(perform: {
            if !isLinkActive {
                timerCancellable?.cancel()
            }
        })
    }
    
    fileprivate func setTimer() {
        timerCancellable = Timer.publish(every: 1, on: .current, in: .common)
                            .autoconnect()
                            .sink { _ in
                                if self.remainingTime > 0 {
                                    self.remainingTime -= 1
                                } else {
                                    timerCancellable?.cancel()
                                }
                            }
    }
    
    fileprivate func hour() -> Int {
        remainingTime / 3600
    }
    
    fileprivate func minute() -> Int {
        remainingTime / 60
    }
    
    fileprivate func second() -> Int {
        remainingTime % 60
    }
}


public struct CircularProgressViewStyle: ProgressViewStyle {
    
    var size: CGFloat
    
    private let lineWidth: CGFloat = 10
    private let defaultProgress = 1.0
    private let accentColor = Color.primary
    
    public func makeBody(configuration: ProgressViewStyleConfiguration) -> some View {
        ZStack {
            configuration.label
            progressCircleView(
                fractionCompleted: configuration.fractionCompleted ?? defaultProgress
            )
            configuration.currentValueLabel
        }
    }
    
    private func progressCircleView(fractionCompleted: Double) -> some View {
        Circle()
            .stroke(accentColor, lineWidth: lineWidth)
            .opacity(0.2)
            .overlay(progressFill(fractionCompleted: fractionCompleted))
            .frame(width: size, height: size)
    }
    
    private func progressFill(fractionCompleted: Double) -> some View {
        Circle()
            .trim(from: 0, to: CGFloat(fractionCompleted))
            .stroke(accentColor, lineWidth: lineWidth)
            .frame(width: size, height: size)
            .rotationEffect(.degrees(-90))
    }
}
