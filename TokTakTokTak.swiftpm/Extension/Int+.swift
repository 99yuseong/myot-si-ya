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
        case 1: return "한"
        case 2: return "두"
        case 3: return "세"
        case 4: return "네"
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
            
            let tensKorean = (tens != 0 ? "" : tens.sinoKoreanTime!)
            let onesKorean = (ones != 0 ? ones.nativeKoreanTime! : "")
            
            return tensKorean + onesKorean
        }
    }
}
