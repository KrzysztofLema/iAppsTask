//
//  FlickrServiceType.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 14/02/2025.
//

@MainActor
protocol FlickrServiceType {
    func fetchFeedFromFlickr(category: FeedCategoryType) async throws -> FlickrFeed
}
