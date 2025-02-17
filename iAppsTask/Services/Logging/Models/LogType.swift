//
//  LogType.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 17/02/2025.
//

import Foundation
import OSLog

public enum LogType: Int, CaseIterable, Sendable {
    case info
    case analytic
    case warning
    case severe

    var emoji: String {
        switch self {
            case .info:
                "👋"
            case .analytic:
                "📈"
            case .warning:
                "⚠️"
            case .severe:
                "🚨"
        }
    }

    var asString: String {
        switch self {
            case .info: "info"
            case .analytic: "analytic"
            case .warning: "warning"
            case .severe: "severe"
        }
    }
}

extension LogType {
    var OSLogType: OSLogType {
        switch self {
            case .info:
                .info
            case .analytic:
                .default
            case .warning:
                .error
            case .severe:
                .fault
        }
    }
}
