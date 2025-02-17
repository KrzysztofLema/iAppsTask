//
//  FlickrManagerTests.swift
//  iAppsTaskTests
//
//  Created by Krzysztof Lema on 17/02/2025.
//
@testable import iAppsTask
import SwiftUI
import Testing

struct FlickrManagerTests {
    @Test("Fetch Feed from Flickr - Success")
    func testFetchFeedFromFlickrSuccess() async throws {
        let mockService = await MockFlickrService()
        let manager = await FlickrManager(service: mockService)

        let feed = try await manager.fetchFeedFromFlickr(category: .cat)

        #expect(feed.items.isEmpty == false)
        #expect(feed.title == FlickrFeed.mock.title)
        #expect(feed.description == FlickrFeed.mock.description)
        #expect(feed.modified == FlickrFeed.mock.modified)
        #expect(feed.link == FlickrFeed.mock.link)
        #expect(feed.generator == FlickrFeed.mock.generator)
    }

    @Test("Fetch Feed from Flickr - Empty Feed")
    func testFetchFeedFromFlickrEmpty() async throws {
        let mockService = await EmptyMockFlickrService()
        let manager = await FlickrManager(service: mockService)

        let feed = try await manager.fetchFeedFromFlickr(category: .cat)

        #expect(feed.items.isEmpty == true, "Feed should be empty")
    }

    @Test("Fetch Feed from Flickr - Multiple Calls")
    func testFetchFeedFromFlickrMultipleCalls() async throws {
        let mockService = await MockFlickrService()
        let manager = await FlickrManager(service: mockService)

        let feed1 = try await manager.fetchFeedFromFlickr(category: .cat)
        let feed2 = try await manager.fetchFeedFromFlickr(category: .dog)

        #expect(feed1 != feed2, "Different categories should return different feeds")
    }
}
