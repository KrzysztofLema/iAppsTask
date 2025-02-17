//
//  LogManager.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 17/02/2025.
//

import Observation

@MainActor
@Observable
class LogManager {
    private let services: [LogService]

    public init(services: [LogService] = []) {
        self.services = services
    }

    public func trackEvent(event: LogEventType) {
        for service in services {
            service.trackEvent(event: event)
        }
    }

    public func trackEvent(eventName: String, parameters: [String: Any]? = nil, type: LogType = .analytic) {
        let event = LogEvent(eventName: eventName, parameters: parameters, type: type)
        for service in services {
            service.trackEvent(event: event)
        }
    }
}
