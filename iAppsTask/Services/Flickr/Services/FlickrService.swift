//
//  FlickrService.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 14/02/2025.
//

struct FlickrService: FlickrServiceType {
    private let networkManager: NetworkManagerType
    private let serviceRequest: ServiceRequest

    init(
        networkManager: NetworkManager = NetworkManager(),
        serviceRequest: ServiceRequest
    ) {
        self.networkManager = networkManager
        self.serviceRequest = serviceRequest
    }

    func fetchFeedFromFlickr(category: FeedCategoryType) async throws -> FlickrFeed {
        var request = serviceRequest
        request.endpoint = .flickrCategory(category: category.rawValue)
        return try await networkManager.makeRequest(request, type: FlickrFeed.self)
    }
}
