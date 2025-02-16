//
//  Date+Extensions.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 12/02/2025.
//

import Foundation

extension Date {
    func addingTimeInterval(days: Int) -> Date {
        addingTimeInterval(TimeInterval(days * 24 * 60 * 60))
    }

    func addingTimeInterval(hours: Int) -> Date {
        addingTimeInterval(TimeInterval(hours * 60 * 60))
    }

    func addingTimeInterval(minutes: Int) -> Date {
        addingTimeInterval(TimeInterval(minutes * 60))
    }

    func formattedString(using format: String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale.current
        return formatter.string(from: self)
    }
}
