//
//  Date+Extensions.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 12/02/2025.
//

import Foundation

extension Date {
    func addingTimeInterval(days: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(days * 24 * 60 * 60))
    }
    
    func addingTimeInterval(hours: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(hours * 60 * 60))
    }
    
    func addingTimeInterval(minutes: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(minutes * 60))
    }
}

