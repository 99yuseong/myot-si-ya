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
    
    func toKoreanTime() -> String {
        "\(toKoreanHours())시 \(toKoreanMinutes())분 \(toKoreanSeconds())초"
    }
    
    func toAmPm() -> String {
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
}
