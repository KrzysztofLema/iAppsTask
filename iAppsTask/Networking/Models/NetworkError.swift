//
//  NetworkError.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 14/02/2025.
//

import Foundation

public enum NetworkError: Error {
    
    case responseMissing
    case dataMissing
    case invalidURLRequest
    case requestFailed(code: Int, responseData: Data)
    case notConnectedToInternet
    case networkError
    case decodingError(error: Error)
    case dataParsingFailed
}
