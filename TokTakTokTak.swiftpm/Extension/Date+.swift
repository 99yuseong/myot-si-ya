//
//  Date+.swift
//  
//
//  Created by 남유성 on 2/1/24.
//

import Foundation

extension Date {
    func toKoreanTime() -> String {
        "\(toKoreanHours())시 \(toKoreanMinutes())분 \(toKoreanSeconds())초"
    }
    
    func toKoreanHours() -> String {
        let hour = Calendar.current.component(.hour, from: self)
        
        return hour.nativeKoreanTime ?? "알 수 없는 시간"
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
