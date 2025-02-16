//
//  FlickrFeed.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 12/02/2025.
//

import Foundation

struct FlickrFeed: Identifiable, Codable, Hashable {
    var id: String {
        UUID().uuidString
    }

    let title: String
    let link: String
    let description: String
    let modified: String
    let generator: String
    let items: [FlickrItem]

    enum CodingKeys: String, CodingKey {
        case title
        case link
        case description
        case modified
        case generator
        case items
    }

    init(
        title: String,
        link: String,
        description: String,
        modified: String,
        generator: String,
        items: [FlickrItem]
    ) {
        self.title = title
        self.link = link
        self.description = description
        self.modified = modified
        self.generator = generator
        self.items = items
    }

    var eventParameters: [String: Any] {
        let dict: [String: Any?] = [
            "feed_\(CodingKeys.title.rawValue)": title,
            "feed_\(CodingKeys.link.rawValue)": link,
            "feed_\(CodingKeys.modified.rawValue)": modified
        ]
        return dict.compactMapValues { $0 }
    }

    static var mock: Self {
        mocks[0]
    }

    static var mocks: [Self] {
        [
            FlickrFeed(
                title: "Recent Uploads tagged cat",
                link: "https://www.flickr.com/photos/tags/cat/",
                description: "Recent cat photos from Flickr",
                modified: "2025-02-12T08:58:26Z",
                generator: "https://www.flickr.com",
                items: FlickrItem.mocks
            ),
            FlickrFeed(
                title: "Recent Uploads tagged dog",
                link: "https://www.flickr.com/photos/tags/dog/",
                description: "Recent dog photos from Flickr",
                modified: "2025-02-12T07:58:26Z",
                generator: "https://www.flickr.com",
                items: FlickrItem.mocks
            ),
            FlickrFeed(
                title: "Recent Uploads tagged cat",
                link: "https://www.flickr.com/photos/tags/cat/",
                description: "Recent cat photos from Flickr",
                modified: "2025-02-12T08:58:26Z",
                generator: "https://www.flickr.com",
                items: FlickrItem.mocks
            ),
            FlickrFeed(
                title: "Recent Uploads tagged cat",
                link: "https://www.flickr.com/photos/tags/cat/",
                description: "Recent cat photos from Flickr",
                modified: "2025-02-12T08:58:26Z",
                generator: "https://www.flickr.com",
                items: FlickrItem.mocks
            )
        ]
    }
}
