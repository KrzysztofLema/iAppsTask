//
//  FeedItem.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 12/02/2025.
//

import Foundation

struct FeedItemModel: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let link: String
    let media: MediaModel
    let dateTaken: Date
    let description: String
    let published: Date
    let author: String
    let authorId: String
    let tags: String
    
    enum CodingKeys: String, CodingKey {
        case id = "item_id"
        case title
        case link
        case media
        case description
        case published
        case author
        case tags
        case dateTaken = "date_taken"
        case authorId = "author_id"
    }
    
    static func itemId(title: String, link: String) -> String {
        "\(title.hashValue)_\(link.hashValue)"
    }
    
    static func new(title: String, link: String, author: String) -> Self {
        FeedItemModel(
            id: itemId(title: title, link: link),
            title: title,
            link: link,
            media: MediaModel(m: "https://live.staticflickr.com/mock.jpg"),
            dateTaken: .now,
            description: "Generated item",
            published: .now,
            author: author,
            authorId: "mock_author_id",
            tags: "mock tag1 tag2"
        )
    }
    
    static var mock: Self {
        mocks[0]
    }
    
    static var mocks: [Self] {
        let now = Date()
        return [
            FeedItemModel(
                id: "mock_item_1",
                title: "Mock Item 1",
                link: "https://www.flickr.com/photos/mock1",
                media: MediaModel(m: "https://live.staticflickr.com/mock1.jpg"),
                dateTaken: now,
                description: "Mock description 1",
                published: now,
                author: "Mock Author 1",
                authorId: "author_1",
                tags: "mock tag1 tag2"
            ),
            FeedItemModel(
                id: "mock_item_2",
                title: "Mock Item 2",
                link: "https://www.flickr.com/photos/mock2",
                media: MediaModel(m: "https://live.staticflickr.com/mock2.jpg"),
                dateTaken: now.addingTimeInterval(hours: -1),
                description: "Mock description 2",
                published: now.addingTimeInterval(minutes: -30),
                author: "Mock Author 2",
                authorId: "author_2",
                tags: "mock tag3 tag4"
            )
        ]
    }
}
