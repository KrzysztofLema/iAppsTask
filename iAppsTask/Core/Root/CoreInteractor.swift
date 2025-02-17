//
//  CoreInteractor.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 14/02/2025.
//

import Foundation

@MainActor
struct CoreInteractor {
    private let flickrManager: FlickrManager
    private let logManager: LogManager
    private let playerManager: PlayerManager

    init(container: DependencyContainer) {
        self.flickrManager = container.resolve(FlickrManager.self)!
        self.logManager = container.resolve(LogManager.self)!
        self.playerManager = container.resolve(PlayerManager.self)!
    }

    func fetchFeedFromFlickr(category: FeedCategoryType) async throws -> FlickrFeed {
        try await flickrManager.fetchFeedFromFlickr(category: category)
    }

    func trackEvent(event: LogEventType) {
        logManager.trackEvent(event: event)
    }

    var currentTime: TimeInterval {
        playerManager.currentTime
    }

    var duration: TimeInterval {
        playerManager.duration
    }

    var isPlaying: Bool {
        playerManager.isPlaying
    }

    var playbackStatus: PlaybackStatus {
        playerManager.playbackStatus
    }

    var playerItem: PlayerItem? {
        playerManager.playerItem
    }

    func play() {
        playerManager.play()
    }

    func pause() {
        playerManager.pause()
    }

    func seek(to time: TimeInterval, completion: ((Bool) -> Void)?) {
        playerManager.seek(to: time)
    }
}
