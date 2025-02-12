//
//  FlickrFeed.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 12/02/2025.
//

import Foundation

struct FlickrFeed: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let link: String
    let description: String
    let modified: String
    let generator: String
    let items: [FlickrItem]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case link
        case description
        case modified
        case generator
        case items
    }
    
    internal init(
        id: String,
        title: String,
        link: String,
        description: String,
        modified: String,
        generator: String,
        items: [FlickrItem]
    ) {
        self.id = id
        self.title = title
        self.link = link
        self.description = description
        self.modified = modified
        self.generator = generator
        self.items = items
    }
    
    var eventParameters: [String: Any] {
        let dict: [String: Any?] = [
            "feed_\(CodingKeys.id.rawValue)": id,
            "feed_\(CodingKeys.title.rawValue)": title,
            "feed_\(CodingKeys.link.rawValue)": link,
            "feed_\(CodingKeys.modified.rawValue)": modified
        ]
        return dict.compactMapValues({ $0 })
    }
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        [
            FlickrFeed(
                id: "mock_feed_1",
                title: "Recent Uploads tagged cat",
                link: "https://www.flickr.com/photos/tags/cat/",
                description: "Recent cat photos from Flickr",
                modified: "2025-02-12T08:58:26Z",
                generator: "https://www.flickr.com",
                items: FlickrItem.mocks
            ),
            FlickrFeed(
                id: "mock_feed_2",
                title: "Recent Uploads tagged dog",
                link: "https://www.flickr.com/photos/tags/dog/",
                description: "Recent dog photos from Flickr",
                modified: "2025-02-12T07:58:26Z",
                generator: "https://www.flickr.com",
                items: FlickrItem.mocks
            )
        ]
    }
}
