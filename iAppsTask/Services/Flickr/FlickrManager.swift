//
//  FlickrManager.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 14/02/2025.
//

import Observation

@MainActor
@Observable
class FlickrManager {
    private let service: FlickrServiceType

    init(service: FlickrServiceType) {
        self.service = service
    }

    func fetchFeedFromFlickr(category: FeedCategoryType) async throws -> FlickrFeed {
        try await service.fetchFeedFromFlickr(category: category)
    }
}
