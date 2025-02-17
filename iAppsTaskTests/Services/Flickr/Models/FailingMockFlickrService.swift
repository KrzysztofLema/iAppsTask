//
//  FailingMockFlickrService.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 17/02/2025.
//

import Foundation
@testable import iAppsTask

struct EmptyMockFlickrService: FlickrServiceType {
    func fetchFeedFromFlickr(category: FeedCategoryType) async throws -> FlickrFeed {
        FlickrFeed(
            title: "",
            link: "",
            description: "",
            modified: "",
            generator: "",
            items: []
        )
    }
}

struct FailingMockFlickrService: FlickrServiceType {
    func fetchFeedFromFlickr(category: FeedCategoryType) async throws -> FlickrFeed {
        throw URLError(.badServerResponse)
    }
}
