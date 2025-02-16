//
//  NetworkManagerType.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 14/02/2025.
//

import Foundation

public protocol NetworkManagerType {
    func makeRequest<T: Codable>(_ request: Request, type: T.Type) async throws -> T
}

public final class NetworkManager: NetworkManagerType {
    private let session: URLSession
    private var jsonParser: JSONParserType

    init(
        sessionConfiguration: URLSessionConfiguration = .default,
        jsonParser: JSONParserType = JSONParser()
    ) {
        sessionConfiguration.requestCachePolicy = .reloadIgnoringLocalCacheData
        sessionConfiguration.urlCache = nil
        self.session = URLSession(configuration: sessionConfiguration)
        self.jsonParser = jsonParser
    }

    public func makeRequest<T: Codable>(_ request: Request, type: T.Type) async throws -> T {
        let response = try await sendRequest(request)
        return try await jsonParser.decode(data: response.data)
    }

    private func sendRequest(_ request: Request) async throws -> Response {
        guard let urlRequest = request.buildRequest() else {
            throw NetworkError.invalidURLRequest
        }

        return try await performRequest(urlRequest)
    }

    private func performRequest(_ request: URLRequest) async throws -> Response {
        let (data, response) = try await session.data(for: request)

        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.responseMissing
        }

        return Response(data: data, httpResponse: response, request: request)
    }
}

public final class MockNetworkManager: NetworkManagerType {
    private let mockData: Data?

    public init(mockData: Data? = nil) {
        self.mockData = mockData
    }

    public func makeRequest<T: Codable>(_ request: Request, type: T.Type) async throws -> T {
        if let data = mockData {
            return try JSONDecoder().decode(T.self, from: data)
        }

        throw NetworkError.responseMissing
    }
}
