//
//  AudioPlayer.swift
//  TokTakTokTak
//
//  Created by 남유성 on 2/1/24.
//

import Foundation
import AVFoundation

class AudioService {
    private var player: AVAudioPlayer?
    private var isMuted: Bool = false
    
    func playAudio(fileName: String, playCount: Int = -1) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            System.shared.log("파일을 찾을 수 없습니다.")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = playCount == -1 ? -1 : playCount - 1
            player?.volume = 0.1
            player?.prepareToPlay()
            player?.play()
        } catch {
            System.shared.log("오디오 재생 중 에러 발생: \(error.localizedDescription)")
        }
    }

    func stopAudio() {
        player?.stop()
        player = nil
    }
    
    func mute() {
        isMuted = true
        player?.volume = 0.0
    }
    
    func unmute() {
        isMuted = false
        player?.volume = 0.1
    }
}
