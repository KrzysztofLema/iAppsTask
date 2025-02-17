//
//  CoreInteractor.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 14/02/2025.
//

@MainActor
struct CoreInteractor {
    private let flickrManager: FlickrManager
    private let logManager: LogManager

    init(container: DependencyContainer) {
        self.flickrManager = container.resolve(FlickrManager.self)!
        self.logManager = container.resolve(LogManager.self)!
    }

    func fetchFeedFromFlickr(category: FeedCategoryType) async throws -> FlickrFeed {
        try await flickrManager.fetchFeedFromFlickr(category: category)
    }

    func trackEvent(event: LogEventType) {
        logManager.trackEvent(event: event)
    }
}
