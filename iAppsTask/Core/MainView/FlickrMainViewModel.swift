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
    func trackEvent(event: LogEventType)
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
        interactor.trackEvent(event: Event.feedItemPressed(feedItem: flickrItem))
        path.append(.feedDetail(feedItem: flickrItem))
    }

    func loadCatFeed() async {
        interactor.trackEvent(event: Event.loadCatFeedStarts)

        do {
            let catFlickrFeed = try await interactor.fetchFeedFromFlickr(category: .cat)
            interactor.trackEvent(event: Event.loadCatFeedSuccess(count: catFlickrFeed.items.count))
            flickrFeed.append(catFlickrFeed)
        } catch {
            interactor.trackEvent(event: Event.loadCatFeedFailed)
        }
    }

    func loadDogFeed() async {
        interactor.trackEvent(event: Event.loadDogFeedStarts)
        do {
            let dogFlickrFeed = try await interactor.fetchFeedFromFlickr(category: .dog)
            interactor.trackEvent(event: Event.loadDogFeedSuccess(count: dogFlickrFeed.items.count))
            flickrFeed.append(dogFlickrFeed)
        } catch {
            interactor.trackEvent(event: Event.loadDogFeedFailed)
        }
    }

    func loadMoutainsFeed() async {
        interactor.trackEvent(event: Event.loadMoutainsStarts)
        do {
            let mountainsFlickrFeed = try await interactor.fetchFeedFromFlickr(category: .moutains)
            interactor.trackEvent(event: Event.loadMoutainsSuccess(count: mountainsFlickrFeed.items.count))
            flickrFeed.append(mountainsFlickrFeed)
        } catch {
            interactor.trackEvent(event: Event.loadMoutainsFailed)
        }
    }

    func loadBoatsFeed() async {
        interactor.trackEvent(event: Event.loadBoatsStarts)
        do {
            let boatFlickrFeed = try await interactor.fetchFeedFromFlickr(category: .boats)
            interactor.trackEvent(event: Event.loadBoatsSuccess(count: boatFlickrFeed.items.count))
            flickrFeed.append(boatFlickrFeed)
        } catch {
            interactor.trackEvent(event: Event.loadBoatsFailed)
        }
    }

    func viewDidLoad() {
        interactor.trackEvent(event: Event.viewDidLoad)
    }

    func viewDidDisappear() {
        interactor.trackEvent(event: Event.viewDidDisapeared)
    }

    enum Event: LogEventType {
        case viewDidLoad
        case viewDidDisapeared
        case loadCatFeedStarts
        case loadCatFeedSuccess(count: Int)
        case loadCatFeedFailed
        case loadDogFeedStarts
        case loadDogFeedSuccess(count: Int)
        case loadDogFeedFailed
        case loadMoutainsStarts
        case loadMoutainsSuccess(count: Int)
        case loadMoutainsFailed
        case loadBoatsStarts
        case loadBoatsSuccess(count: Int)
        case loadBoatsFailed
        case feedItemPressed(feedItem: FlickrItem)

        var parameters: [String: Any]? {
            switch self {
                default:
                    nil
            }
        }

        var type: LogType {
            switch self {
                case .loadBoatsFailed, .loadCatFeedFailed, .loadDogFeedFailed, .loadMoutainsFailed:
                    .severe
                default:
                    .analytic
            }
        }

        var eventName: String {
            switch self {
                case .viewDidLoad: "Flickr_Main_View_Did_Load"
                case .viewDidDisapeared: "Flickr_Main_View_Did_Dissapear"
                case .loadCatFeedStarts: "Flickr_Main_View_Load_Cat_Starts"
                case .loadCatFeedSuccess: "Flickr_Main_View_Load_Cat_Success"
                case .loadCatFeedFailed: "Flickr_Main_View_Load_Cat_Feed_Failed"
                case .loadDogFeedStarts: "Flickr_Main_View_Load_Dog_Feed_Starts"
                case .loadDogFeedSuccess: "Flickr_Main_View_Load_Dog_Feed_Success"
                case .loadDogFeedFailed: "Flickr_Main_View_Load_Dog_Feed_Failed"
                case .loadMoutainsStarts: "Flickr_Main_View_Load_Moutains_Starts"
                case .loadMoutainsSuccess: "Flickr_Main_View_Load_Moutains_Success"
                case .loadMoutainsFailed: "Flickr_Main_View_Load_Moutains_Falied"
                case .loadBoatsStarts: "Flickr_Main_View_Load_Boats_Starts"
                case .loadBoatsSuccess: "Flickr_Main_View_Load_Boats_Success"
                case .loadBoatsFailed: "Flickr_Main_View_Load_Boats_Failed"
                case .feedItemPressed: "Flickr_Main_View_Feed_Item_Pressed"
            }
        }
    }
}
