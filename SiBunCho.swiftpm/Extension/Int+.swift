//
//  Int+.swift
//  TokTakTokTak
//
//  Created by 남유성 on 2/1/24.
//

import Foundation

extension Int {
    var sinoKoreanTime: String? {
        switch self {
        case 0: return "영"
        case 1: return "일"
        case 2: return "이"
        case 3: return "삼"
        case 4: return "사"
        case 5: return "오"
        case 6: return "육"
        case 7: return "칠"
        case 8: return "팔"
        case 9: return "구"
        case 10: return "십"
        default:
            guard self < 100 else {
                System.shared.log("More than 100 is not supported")
                return nil
            }
            
            let tens = self / 10
            let ones = self % 10
            
            let tensKorean = (tens != 1 ? tens.sinoKoreanTime!: "") + "십"
            let onesKorean = (ones != 0 ? ones.sinoKoreanTime! : "")
            
            return tensKorean + onesKorean
        }
    }
    
    var nativeKoreanTime: String? {
        switch self {
        case 0: return "영"
        case 1: return "한"
        case 2: return "두"
        case 3: return "세"
        case 4: return "네"
        case 5, 6, 7, 8, 9, 10, 20: return self.nativeKorean
        default:
            guard self < 30 else {
                System.shared.log("More than 30 is not supported")
                return nil
            }
            
            let tens = self - self % 10
            let ones = self % 10
            
            let tensKorean = (tens != 0 ? tens.nativeKoreanTime! : "")
            let onesKorean = (ones != 0 ? ones.nativeKoreanTime! : "")
            
            return tensKorean + onesKorean
        }
    }
    
    var nativeKorean: String? {
        switch self {
        case 1: return "하나"
        case 2: return "둘"
        case 3: return "셋"
        case 4: return "넷"
        case 5: return "다섯"
        case 6: return "여섯"
        case 7: return "일곱"
        case 8: return "여덟"
        case 9: return "아홉"
        case 10: return "열"
        case 20: return "스물"
        default:
            guard self < 30 else {
                System.shared.log("More than 30 is not supported")
                return nil
            }
            
            let tens = self - self % 10
            let ones = self % 10
            
            let tensKorean = (tens != 0 ? tens.nativeKoreanTime! : "")
            let onesKorean = (ones != 0 ? ones.nativeKoreanTime! : "")
            
            return tensKorean + onesKorean
        }
    }
    
    var nativeTimePronunciation: String? {
        switch self {
        case 0: return "young"
        case 1: return "han"
        case 2: return "du"
        case 3: return "se"
        case 4: return "ne"
        case 5, 6, 7, 8, 9, 10: return self.nativePronunciation
        case 11: return "yeol-han"
        case 12: return "yeol-du"
        default:
            System.shared.log("More than 12 is not supported")
            return nil
        }
    }
    
    var sinoTimePronunciation: String? {
        switch self {
        case 0: return "young"
        case 1, 2, 3, 4, 5, 6, 7, 8, 9, 10: return self.sinoPronunciation
        default:
            guard (11..<60) ~= self else { 
                System.shared.log("More than 59 is not supported")
                return nil
            }
            
            let tens = self / 10
            let ones = self % 10
            
            let tensKorean = (tens != 1 ? tens.sinoTimePronunciation! + "-ship" : "ship")
            let onesKorean = (ones != 0 ? "-" + ones.sinoTimePronunciation! : "")
            
            return tensKorean + onesKorean
        }
    }
    
    var nativePronunciation: String? {
        switch self {
        case 1: return "ha-na"
        case 2: return "dul"
        case 3: return "set"
        case 4: return "net"
        case 5: return "da-seot"
        case 6: return "yeo-seot"
        case 7: return "il-gop"
        case 8: return "yeo-deol"
        case 9: return "a-hop"
        case 10: return "yeol"
        default:
            System.shared.log("More than 10 is not supported")
            return nil
        }
    }
    
    var sinoPronunciation: String? {
        switch self {
        case 1: return "il"
        case 2: return "ee"
        case 3: return "sam"
        case 4: return "sa"
        case 5: return "oh"
        case 6: return "yuk"
        case 7: return "chil"
        case 8: return "pal"
        case 9: return "gu"
        case 10: return "ship"
        case 100: return "baek"
        case 1000: return "cheon"
        default:
            System.shared.log("This number is not supported")
            return nil
        }
    }
}
