import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var currentTime = Date()
    @State private var isTimerRunning: Bool = false
    
    private let player = AudioPlayer()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        HStack {
            
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("\"똑딱똑딱\" - Hangeul Clock")
                        .aggro(.bold, size: 32)
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
                        print("fullsize btn tap")
                    }
                    IconButton(text: "Aa") {
                        print("language btn tap")
                    }
                }
                Spacer()
            }
            .padding(.top, 100)
            .padding(.leading, 100)
            
            
            Spacer()
            VStack(alignment: .trailing, spacing: -18) {
                Spacer()
                Text("\(currentTime.toAmPm())")
                HStack(spacing: 0) {
                    Text("\(currentTime.toKoreanHours())")
                    Text("시")
                        .foregroundStyle(.tertiary)
                }
                HStack(spacing: 0) {
                    Text("\(currentTime.toKoreanMinutes())")
                    Text("분")
                        .foregroundStyle(.tertiary)
                }
                HStack(spacing: 0) {
                    Text("\(currentTime.toKoreanSeconds())")
                    Text("초")
                        .foregroundStyle(.tertiary)
                }
                .onReceive(timer) {
                    currentTime = $0
                    if !isTimerRunning {
                        player.playAudio(fileName: "clock2")
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
}
