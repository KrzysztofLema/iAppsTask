//
//  LogService.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 17/02/2025.
//

public protocol LogService: Sendable {
    func trackEvent(event: LogEventType)
}
