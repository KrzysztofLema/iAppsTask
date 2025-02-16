//
//  CoreInteractor.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 14/02/2025.
//

@MainActor
struct CoreInteractor {
    
    private let flickrManager: FlickrManager
    
    init(container: DependencyContainer) {
        flickrManager = container.resolve(FlickrManager.self)!
    }
    
    func fetchFeedFromFlickr(category: FeedCategoryType) async throws -> FlickrFeed {
        try await flickrManager.fetchFeedFromFlickr(category: category)
    }
}
