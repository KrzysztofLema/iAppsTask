@testable import iAppsTask
import SwiftUI
import Testing

struct FlickrModelsTests {
    @Test("FlickrFeed Initialization")
    func testFlickrFeedInitialization() async throws {
        let mockFeed = FlickrFeed.mock
        #expect(mockFeed.title == "Recent Uploads tagged cat")
        #expect(mockFeed.items.count == FlickrItem.mocks.count)
    }

    @Test("FlickrFeed Event Parameters")
    func testFlickrFeedEventParameters() async throws {
        let mockFeed = FlickrFeed.mock
        let params = mockFeed.eventParameters
        #expect(params["feed_title"] as? String == mockFeed.title)
        #expect(params["feed_link"] as? String == mockFeed.link)
    }

    @Test("FlickrFeed Codable Conformance")
    func testFlickrFeedCodableConformance() async throws {
        let originalFeed = FlickrFeed.mock
        let encoder = JSONEncoder()
        let data = try encoder.encode(originalFeed)
        let decoder = JSONDecoder()
        let decodedFeed = try decoder.decode(FlickrFeed.self, from: data)

        #expect(decodedFeed.title == originalFeed.title)
        #expect(decodedFeed.link == originalFeed.link)
        #expect(decodedFeed.description == originalFeed.description)
        #expect(decodedFeed.modified == originalFeed.modified)
        #expect(decodedFeed.generator == originalFeed.generator)
        #expect(decodedFeed.items.count == originalFeed.items.count)

        // Compare items with tolerance for dates
        let tolerance: TimeInterval = 1

        for i in 0..<originalFeed.items.count {
            let originalItem = originalFeed.items[i]
            let decodedItem = decodedFeed.items[i]

            #expect(decodedItem.title == originalItem.title)
            #expect(decodedItem.link == originalItem.link)
            #expect(decodedItem.media == originalItem.media)
            #expect(decodedItem.description == originalItem.description)
            #expect(decodedItem.author == originalItem.author)
            #expect(decodedItem.authorId == originalItem.authorId)
            #expect(decodedItem.tags == originalItem.tags)

            #expect(decodedItem.dateTaken.timeIntervalSince(originalItem.dateTaken) < tolerance)
            #expect(decodedItem.published.timeIntervalSince(originalItem.published) < tolerance)
        }
    }

    @Test("FlickrItem Initialization")
    func testFlickrItemInitialization() async throws {
        let mockItem = FlickrItem.mock
        #expect(mockItem.title == FlickrItem.mocks[0].title)
        #expect(mockItem.authorId == FlickrItem.mocks[0].authorId)
        #expect(mockItem.tags == FlickrItem.mocks[0].tags)
    }

    @Test("FlickrItem Event Parameters")
    func testFlickrItemEventParameters() async throws {
        let mockItem = FlickrItem.mock
        let params = mockItem.eventParameters
        #expect(params["item_title"] as? String == mockItem.title)
        #expect(params["item_date_taken"] as? Date != nil)
    }

    @Test("FlickrItem Codable Conformance")
    func testFlickrItemCodableConformance() async throws {
        let originalItem = FlickrItem.mock
        let encoder = JSONEncoder()
        let data = try encoder.encode(originalItem)
        let decoder = JSONDecoder()
        let decodedItem = try decoder.decode(FlickrItem.self, from: data)
        #expect(decodedItem.title == originalItem.title)
        #expect(decodedItem.link == originalItem.link)
        #expect(decodedItem.media == originalItem.media)
        #expect(decodedItem.description == originalItem.description)
        #expect(decodedItem.author == originalItem.author)
        #expect(decodedItem.authorId == originalItem.authorId)
        #expect(decodedItem.tags == originalItem.tags)

        let tolerance: TimeInterval = 1

        #expect(decodedItem.dateTaken.timeIntervalSince(originalItem.dateTaken) < tolerance)
        #expect(decodedItem.published.timeIntervalSince(originalItem.published) < tolerance)
    }

    @Test("FlickrMedia Initialization")
    func testFlickrMediaInitialization() async throws {
        let mockMedia = FlickrMedia(url: "https://example.com/image.jpg")
        #expect(mockMedia.url == "https://example.com/image.jpg")
    }

    @Test("FlickrMedia Codable Conformance")
    func testFlickrMediaCodableConformance() async throws {
        let originalMedia = FlickrMedia(url: "https://example.com/image.jpg")
        let encoder = JSONEncoder()
        let data = try encoder.encode(originalMedia)
        let decoder = JSONDecoder()
        let decodedMedia = try decoder.decode(FlickrMedia.self, from: data)
        #expect(decodedMedia == originalMedia)
    }
}
