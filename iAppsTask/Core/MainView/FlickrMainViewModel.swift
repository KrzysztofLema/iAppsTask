//
//  FlickrMainViewModel.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 13/02/2025.
//

import Observation

@MainActor
protocol FlickrMainViewInteractor {
    func fetchFeedFromFlickr(category: FeedCategoryType) async throws -> FlickrFeed
}

extension CoreInteractor: FlickrMainViewInteractor {}

@Observable
@MainActor
final class FlickrMainViewModel {
    private let interactor: FlickrMainViewInteractor

    private(set) var flickrFeed: [FlickrFeed] = []

    var path: [NavigationPathOption] = []

    init(interactor: FlickrMainViewInteractor) {
        self.interactor = interactor
    }

    func onFlickrItemPressed(flickrItem: FlickrItem) {
        path.append(.feedDetail(feedItem: flickrItem))
    }

    func loadCatFeed() async {
        do {
            let catFlickrFeed = try await interactor.fetchFeedFromFlickr(category: .cat)
            flickrFeed.append(catFlickrFeed)
        } catch {}
    }

    func loadDogFeed() async {
        do {
            let dogFlickrFeed = try await interactor.fetchFeedFromFlickr(category: .dog)
            flickrFeed.append(dogFlickrFeed)
        } catch {}
    }

    func loadMoutainsFeed() async {
        do {
            let mountainsFlickrFeed = try await interactor.fetchFeedFromFlickr(category: .moutains)
            flickrFeed.append(mountainsFlickrFeed)
        } catch {}
    }

    func loadBoatsFeed() async {
        do {
            let boatFlickrFeed = try await interactor.fetchFeedFromFlickr(category: .boats)
            flickrFeed.append(boatFlickrFeed)
        } catch {}
    }
}
