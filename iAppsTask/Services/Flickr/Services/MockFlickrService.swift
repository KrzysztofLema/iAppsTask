//
//  MockFlickrService.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 14/02/2025.
//

struct MockFlickrService: FlickrServiceType {
    func fetchFeedFromFlickr(category: FeedCategoryType) async throws -> FlickrFeed {
        .mock
    }
}
