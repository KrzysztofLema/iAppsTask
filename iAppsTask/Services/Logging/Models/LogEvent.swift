//
//  LogEvent.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 17/02/2025.
//

public protocol LogEventType {
    var eventName: String { get }
    var parameters: [String: Any]? { get }
    var type: LogType { get }
}

public struct LogEvent: LogEventType {
    public var eventName: String
    public var type: LogType
    public var parameters: [String: Any]?

    public init(eventName: String, parameters: [String: Any]? = nil, type: LogType = .analytic) {
        self.eventName = eventName
        self.parameters = parameters
        self.type = type
    }
}
