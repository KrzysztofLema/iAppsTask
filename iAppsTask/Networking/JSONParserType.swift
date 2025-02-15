//
//  JSONParserType.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 14/02/2025.
//

import Foundation

public protocol JSONParserType {
    func decode<T: Decodable>(data: Data) async throws -> T
}

public final class JSONParser: JSONParserType {
    
    private let decoder = JSONDecoder()
    
    public func decode<T: Decodable>(data: Data) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch let error {
            #if DEBUG
            print("Decode error = \(error)")
            #endif
            throw NetworkError.dataParsingFailed
        }
    }
}
