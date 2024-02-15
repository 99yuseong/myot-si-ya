//
//  SpeechService.swift
//
//
//  Created by 남유성 on 2/2/24.
//

import Foundation
import AVFoundation

class SpeechService {
    private var synthesizer = AVSpeechSynthesizer()
    
    public func speakInKorean(_ text: String) {
        let speechUtterance = AVSpeechUtterance(string: text)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        speechUtterance.volume = 1.0
        speechUtterance.rate = 0.4
                    
        synthesizer.speak(speechUtterance)
    }
}
