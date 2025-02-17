//
//  ConsoleService.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 17/02/2025.
//

import Foundation

public struct ConsoleService: LogService {
    private var printParameters: Bool
    private let logger = LogSystem()

    public init(printParameters: Bool = true) {
        self.printParameters = printParameters
    }

    public func trackEvent(event: LogEventType) {
        var value = "\(event.type.emoji) \(event.eventName)"
        if printParameters, let params = event.parameters, !params.isEmpty {
            let sortedKeys = params.keys.sorted()
            for key in sortedKeys {
                if let paramValue = params[key] {
                    value += "\n  (key: \"\(key)\", value: \(paramValue))"
                }
            }
        }

        logger.log(level: event.type, message: "\(value)")
    }
}
