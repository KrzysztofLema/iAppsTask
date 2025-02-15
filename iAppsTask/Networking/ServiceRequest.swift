//
//  ServiceRequest.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 14/02/2025.
//

import Foundation

public protocol ServiceRequest: Request {
    var endpoint: ServiceEndpoint? { get set }
    var parameters: [URLQueryItem]? { get set }
    var body: [String: AnyObject]? { get set }
    var additionalHeaders: [HTTPHeaderField: String] { get set }
}

public enum ServiceEndpoint {
    case flickrCategory(category: String)
}

public enum HTTPHeaderField: String {
    case contentType = "Content-Type"
}
