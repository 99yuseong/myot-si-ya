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
    
    func toKoreanPronunciation() -> String {
        let hour = Calendar.current.component(.hour, from: self)
        let minute = Calendar.current.component(.minute, from: self)
        let second = Calendar.current.component(.second, from: self)
        
        var pron: String = ""
        
        pron += hour > 12 ? "ohu  " : "ojeon  "
        pron += (hour > 12 ? hour - 12: hour).nativeTimePronunciation! + "-si  "
        pron += minute.sinoTimePronunciation! + "-bun  "
        pron += second.sinoTimePronunciation! + "-cho"
        
        return pron
    }
}
