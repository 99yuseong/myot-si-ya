//
//  SwiftUIView.swift
//  
//
//  Created by 남유성 on 2/5/24.
//

import SwiftUI
import Combine

struct TimerProgressView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var timerCancellable: Cancellable? = nil
    @State private var isTimerRunning = false
    @State private var isPaused = false
    @State private var fontSize: CGFloat = 180
    @State private var isTimeOver = false
    @State private var isHiddenTimer = false
    
    @Binding var remainingTime: Int
    @Binding var totalTime: Int
    @Binding var isLinkActive: Bool
    
    @State private var fontSize1: CGFloat = 180
    @State private var fontSize2: CGFloat = 180
    @State private var fontSize3: CGFloat = 180
    @State private var fontSize4: CGFloat = 180
    @State private var timer = Timer()
    @State private var audioSerVice: AudioService? = AudioService()
    var workItem: DispatchWorkItem?
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        HStack(spacing: 32) {
                            ControlButton(icon: Icon.cancel) {
                                audioSerVice = nil
                                dismiss.callAsFunction()
                            }
                            
                            if !isTimeOver {
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
                    }
                    .padding([.leading, .bottom, .trailing], 100)
                }
                
                if remainingTime > 0 {
                    ProgressView(value: Double(max(remainingTime - 1, 0)) / Double(totalTime - 1))
                        .progressViewStyle(CircularProgressViewStyle(size: 570, remainingTime: $remainingTime))
                        .animation(.linear(duration: 1), value: remainingTime)
                    
                    if remainingTime <= 10 {
                        Text(second().sinoKoreanTime!)
                            .padding(.top, 28)
                            .animatableSystemFont(weight: .bold, size: fontSize)
                    } else {
                        HStack(spacing: 0) {
                            Spacer(minLength: 0)
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
                            .padding(.top, 28)
                        }
                        .frame(width: 384)
                        .aggro(.bold, size: 100)
                    }
                } else {
                    HStack(spacing: 0) {
                        Text("띠")
                            .animatableSystemFont(weight: .bold, size: fontSize1)
                            .animation(.interactiveSpring(duration: 0.1, extraBounce: 0.3), value: fontSize1)
                            .opacity(fontSize1 > 0 ? 1 : 0)
                        Text("띠")
                            .animatableSystemFont(weight: .bold, size: fontSize2)
                            .animation(.interactiveSpring(duration: 0.1, extraBounce: 0.3), value: fontSize2)
                            .opacity(fontSize2 > 0 ? 1 : 0)
                        Text("띠")
                            .animatableSystemFont(weight: .bold, size: fontSize3)
                            .animation(.interactiveSpring(duration: 0.1, extraBounce: 0.25), value: fontSize3)
                            .opacity(fontSize3 > 0 ? 1 : 0)
                        Text("띠")
                            .animatableSystemFont(weight: .bold, size: fontSize4)
                            .animation(.interactiveSpring(duration: 0.1, extraBounce: 0.2), value: fontSize4)
                            .opacity(fontSize4 > 0 ? 1 : 0)
                    }
                    .padding(.top, 30)
                }
            }
        }
        .ignoresSafeArea()
        .background(Color.bg)
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            if !isTimerRunning {
                setTimer()
                isTimerRunning = true
            }
        }
        .onDisappear {
            if !isLinkActive {
                timerCancellable?.cancel()
            }
        }
    }
    
    fileprivate func setTimer() {
        isTimeOver = false
        timerCancellable = Timer.publish(every: 1, on: .current, in: .common)
                            .autoconnect()
                            .sink { _ in
                                if remainingTime > 0 {
                                    
                                    remainingTime -= 1

                                    if remainingTime <= 10 {
                                        scaleFont()
                                    }
                                    
                                    if remainingTime == 0 {
                                        isTimeOver = true
                                        effectTimer()
                                    }
                                    
                                } else {
                                    effectTimer()
                                }
                            }
    }

    fileprivate func effectTimer() {
        fontSize1 = 0
        fontSize2 = 0
        fontSize3 = 0
        fontSize4 = 0
        
        let tasks: [() -> Void] = [
            { fontSize1 = 180 },
            { fontSize2 = 180 },
            { fontSize3 = 180 },
            { fontSize4 = 180 }
        ]

        var idx = 0
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            
            if idx == 0 {
                audioSerVice?.playAudio(fileName: "Timer", playCount: 1)
            }
            
            tasks[idx]()
            idx += 1
            
            if idx >= tasks.count {
                timer.invalidate()
            }
        }
    }

    
    fileprivate func scaleFont() {
        fontSize = 0
        withAnimation {
            fontSize = 180
        }
    }
    
    fileprivate func hour() -> Int {
        remainingTime / 3600
    }
    
    fileprivate func minute() -> Int {
        remainingTime / 60 - hour() * 60
    }
    
    fileprivate func second() -> Int {
        remainingTime % 60
    }
}


public struct CircularProgressViewStyle: ProgressViewStyle {
    
    var size: CGFloat
    @Binding var remainingTime: Int
    
    private let lineWidth: CGFloat = 10
    private let defaultProgress = 1.0
    
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
            .stroke(remainingTime > 10 ? .primary : Color.red, lineWidth: lineWidth)
            .opacity(0.2)
            .overlay(progressFill(fractionCompleted: fractionCompleted))
            .frame(width: size, height: size)
    }
    
    private func progressFill(fractionCompleted: Double) -> some View {
        Circle()
            .trim(from: 0, to: CGFloat(fractionCompleted))
            .stroke(remainingTime > 10 ? .primary : Color.red, lineWidth: lineWidth)
            .frame(width: size, height: size)
            .rotationEffect(.degrees(-90))
    }
}
