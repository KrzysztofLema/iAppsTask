//
//  Feed.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 12/02/2025.
//

import Foundation

struct FeedModel: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let link: String
    let description: String
    let modified: Date
    let generator: String
    let items: [FeedItemModel]
    
    enum CodingKeys: String, CodingKey {
        case id = "feed_id"
        case title
        case link
        case description
        case modified
        case generator
        case items
    }
    
    static func feedId(title: String, link: String) -> String {
        "\(title.hashValue)_\(link.hashValue)"
    }
    
    static func new(title: String, link: String, generator: String) -> Self {
        FeedModel(
            id: feedId(title: title, link: link),
            title: title,
            link: link,
            description: "Generated feed",
            modified: .now,
            generator: generator,
            items: []
        )
    }
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        let now = Date()
        return [
            FeedModel(
                id: "mock_feed_1",
                title: "Mock Flickr Feed",
                link: "https://www.flickr.com",
                description: "Mock feed description",
                modified: now,
                generator: "Mock Generator",
                items: FeedItemModel.mocks
            ),
            FeedModel(
                id: "mock_feed_2",
                title: "Another Mock Feed",
                link: "https://www.flickr.com/mock2",
                description: "Second mock feed",
                modified: now.addingTimeInterval(hours: -1),
                generator: "Mock Generator 2",
                items: FeedItemModel.mocks
            )
        ]
    }
}
