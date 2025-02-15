//
//  Response.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 14/02/2025.
//

import Foundation

public struct Response {
    
    public let data: Data
    public let httpResponse: HTTPURLResponse
    public let request: URLRequest
}
