//
//  SnapshotTests.swift
//  iAppsTaskTests
//
//  Created by Krzysztof Lema on 17/02/2025.
//

@testable import iAppsTask
import SnapshotTesting
import XCTest

@MainActor
final class SnapShotTests: XCTestCase {
    func test_mainView_shows_loader_avter_open() {
        let viewModel = FlickrMainViewModel(interactor: CoreInteractor(container: DevPreview.shared.container))
        let view = FlickrMainView(viewModel: viewModel)

        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
    }

    func test_mainView_shows_loaded_feed_after_loading() {
        let viewModel = FlickrMainViewModel(interactor: CoreInteractor(container: DevPreview.shared.container))
        let view = FlickrMainView(viewModel: viewModel)

        let expectation = expectation(description: "Waiting for async tasks")

        Task {
            await viewModel.loadCatFeed()
            await viewModel.loadDogFeed()
            await viewModel.loadMoutainsFeed()
            await viewModel.loadBoatsFeed()

            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)

        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13Pro)))
    }
}
