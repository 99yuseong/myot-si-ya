//
//  Date+.swift
//  
//
//  Created by 남유성 on 2/1/24.
//

import Foundation

extension Date {
    func toFormat(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func toHours() -> Int {
        let hour = Calendar.current.component(.hour, from: self)
        
        return hour > 12 ? hour - 12 : hour
    }
    
    func toMinutes() -> Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    func toSeconds() -> Int {
        return Calendar.current.component(.second, from: self)
    }
    
    func toAmPm() -> String {
        let hour = Calendar.current.component(.hour, from: self)
        
        return hour > 12 ? "PM" : "AM"
    }
    
    func toKoreanTime() -> String {
        "\(toKoreanAmPm()) \(toKoreanHours())시 \(toKoreanMinutes())분 \(toKoreanSeconds())초"
    }
    
    func toKoreanTimeSection() -> String {
        let hour = Calendar.current.component(.hour, from: self)
        let minute = Calendar.current.component(.minute, from: self)
        
        if hour == 12 && minute == 0 {
            return "정오"
        }
        
        if hour == 24 && minute == 0 {
            return "자정"
        }
        
        if (0..<3) ~= hour {
            return "밤"
        }
        
        if (3..<6) ~= hour {
            return "새벽"
        }
        
        if (6..<12) ~= hour {
            return "아침"
        }
        
        if (12..<18) ~= hour {
            return "낮"
        }
        
        if (18..<21) ~= hour {
            return "저녁"
        }
        
        return "밤"
    }
    
    func toKoreanAmPm() -> String {
        let hour = Calendar.current.component(.hour, from: self)
        
        return hour > 12 ? "오후" : "오전"
    }
    
    func toKoreanHours() -> String {
        let hour = Calendar.current.component(.hour, from: self)
        
        return (hour > 12 ? hour - 12 : hour).nativeKoreanTime ?? "알 수 없는 시간"
    }
    
    func toKoreanMinutes() -> String {
        let minute = Calendar.current.component(.minute, from: self)
        
        return minute.sinoKoreanTime ?? "알 수 없는 시간"
    }
    
    func toKoreanSeconds() -> String {
        let second = Calendar.current.component(.second, from: self)
        
        return second.sinoKoreanTime ?? "알 수 없는 시간"
    }
    
    func toKoreanPronunciation(
        isM: Bool = true,
        isS: Bool = true,
        isTimeSection: Bool = false
    ) -> String {
        
        let hour = Calendar.current.component(.hour, from: self)
        let minute = Calendar.current.component(.minute, from: self)
        let second = Calendar.current.component(.second, from: self)
        
        var pron: String = ""
        
        if isTimeSection {
            pron += self.toKoreanTimeSectionPronunciation()
        } else {
            pron += hour > 12 ? "ohu" : "ojeon"
        }
    
        pron += "  " + (hour > 12 ? hour - 12: hour).nativeTimePronunciation! + "-si"
        
        if isM {
            pron += "  " + minute.sinoTimePronunciation! + "-bun"
        }
        
        if isM && isS {
            pron += "  " + second.sinoTimePronunciation! + "-cho"
        }
        
        return pron
    }
    
    func toKoreanTimeSectionPronunciation() -> String {
        let hour = Calendar.current.component(.hour, from: self)
        let minute = Calendar.current.component(.minute, from: self)
        
        if hour == 12 && minute == 0 {
            return "jeong-oh"
        }
        
        if hour == 24 && minute == 0 {
            return "ja-jeong"
        }
        
        if (0..<3) ~= hour {
            return "bam"
        }
        
        if (3..<6) ~= hour {
            return "sae-byeok"
        }
        
        if (6..<12) ~= hour {
            return "a-chim"
        }
        
        if (12..<18) ~= hour {
            return "nat"
        }
        
        if (18..<21) ~= hour {
            return "jeo-nyeok"
        }
        
        return "bam"
    }
}
