import SwiftUI

struct ContentView: View {
    @State private var currentTime = Date()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text("현재 시간")
            Text("\(currentTime.toKoreanTime())")
                .aggro(.bold, size: 30)
                .onReceive(timer) {
                    self.currentTime = $0
                }
            }
        }
}
