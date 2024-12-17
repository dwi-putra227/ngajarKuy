//
//  DateHelper.swift
//  ngajarKuy
//
//  Created by Putra  on 15/12/24.
//

import Foundation

extension Date {
    func getMonthName() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy" // Format: December 2024
        return formatter.string(from: self)
    }
    
    func startOfMonth() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)!
    }
    
    func daysInMonth() -> Int {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: self)!
        return range.count
    }
    
    func dayOfWeek() -> Int {
        let calendar = Calendar.current
        return calendar.component(.weekday, from: self) - 1 // Sunday = 0
    }
}
