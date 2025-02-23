//
//  FlickrItem.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 12/02/2025.
//

import Foundation

struct FlickrItem: Identifiable, Codable, Hashable {
    var id: String {
        UUID().uuidString
    }

    let title: String
    let link: String
    let media: FlickrMedia
    let dateTaken: Date
    let description: String
    let published: Date
    let author: String
    let authorId: String
    let tags: String

    enum CodingKeys: String, CodingKey {
        case title
        case link
        case media
        case dateTaken = "date_taken"
        case description
        case published
        case author
        case authorId = "author_id"
        case tags
    }

    init(
        title: String,
        link: String,
        media: FlickrMedia,
        dateTaken: Date,
        description: String,
        published: Date,
        author: String,
        authorId: String,
        tags: String
    ) {
        self.title = title
        self.link = link
        self.media = media
        self.dateTaken = dateTaken
        self.description = description
        self.published = published
        self.author = author
        self.authorId = authorId
        self.tags = tags
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.link = try container.decode(String.self, forKey: .link)
        self.media = try container.decode(FlickrMedia.self, forKey: .media)
        self.description = try container.decode(String.self, forKey: .description)
        self.author = try container.decode(String.self, forKey: .author)
        self.authorId = try container.decode(String.self, forKey: .authorId)
        self.tags = try container.decode(String.self, forKey: .tags)

        let dateTakenString = try container.decode(String.self, forKey: .dateTaken)
        self.dateTaken = DateFormatter.iso8601Full.date(from: dateTakenString) ?? Date()

        let publishedString = try container.decode(String.self, forKey: .published)
        self.published = DateFormatter.iso8601Full.date(from: publishedString) ?? Date()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(link, forKey: .link)
        try container.encode(media, forKey: .media)
        try container.encode(description, forKey: .description)
        try container.encode(author, forKey: .author)
        try container.encode(authorId, forKey: .authorId)
        try container.encode(tags, forKey: .tags)
        try container.encode(DateFormatter.iso8601Full.string(from: dateTaken), forKey: .dateTaken)
        try container.encode(DateFormatter.iso8601Full.string(from: published), forKey: .published)
    }

    var eventParameters: [String: Any] {
        let dict: [String: Any?] = [
            "item_\(CodingKeys.title.rawValue)": title,
            "item_\(CodingKeys.authorId.rawValue)": authorId,
            "item_\(CodingKeys.dateTaken.rawValue)": dateTaken,
            "item_\(CodingKeys.published.rawValue)": published
        ]
        return dict.compactMapValues { $0 }
    }

    static var mock: Self {
        mocks[0]
    }

    static var mocks: [Self] {
        let now = Date()
        return [
            FlickrItem(
                title: "Charlie and Freddie",
                link: "https://www.flickr.com/photos/stuart166axe/54322719959/",
                media: FlickrMedia(url: "https://live.staticflickr.com/65535/54322719959_6e427762af_m.jpg"),
                dateTaken: now.addingTimeInterval(days: -1),
                description: "Brothers and littermates in arms Charlie Boy and Freddie",
                published: now,
                author: "Stuart Axe",
                authorId: "7733434@N04",
                tags: "charlie charlieboy cat gingercat"
            ),
            FlickrItem(
                title: "Living the life",
                link: "https://www.flickr.com/photos/127489829@N06/54322143104/",
                media: FlickrMedia(url: "https://live.staticflickr.com/65535/54322143104_073ea5c581_m.jpg"),
                dateTaken: now.addingTimeInterval(hours: -2),
                description: "Cat living the life in UAE",
                published: now.addingTimeInterval(hours: -1),
                author: "Visual Photons",
                authorId: "127489829@N06",
                tags: "ras al khaimah uae cat"
            ),
            FlickrItem(
                title: "Living the life",
                link: "https://www.flickr.com/photos/127489829@N06/54322143104/",
                media: FlickrMedia(url: "https://live.staticflickr.com/65535/54322143104_073ea5c581_m.jpg"),
                dateTaken: now.addingTimeInterval(hours: -2),
                description: "Cat living the life in UAE",
                published: now.addingTimeInterval(hours: -1),
                author: "Visual Photons",
                authorId: "127489829@N06",
                tags: "ras al khaimah uae cat"
            ),
            FlickrItem(
                title: "Living the life",
                link: "https://www.flickr.com/photos/127489829@N06/54322143104/",
                media: FlickrMedia(url: "https://live.staticflickr.com/65535/54322143104_073ea5c581_m.jpg"),
                dateTaken: now.addingTimeInterval(hours: -2),
                description: "Cat living the life in UAE",
                published: now.addingTimeInterval(hours: -1),
                author: "Visual Photons",
                authorId: "127489829@N06",
                tags: "ras al khaimah uae cat"
            ),
            FlickrItem(
                title: "Living the life",
                link: "https://www.flickr.com/photos/127489829@N06/54322143104/",
                media: FlickrMedia(url: "https://live.staticflickr.com/65535/54322143104_073ea5c581_m.jpg"),
                dateTaken: now.addingTimeInterval(hours: -2),
                description: "Cat living the life in UAE",
                published: now.addingTimeInterval(hours: -1),
                author: "Visual Photons",
                authorId: "127489829@N06",
                tags: "ras al khaimah uae cat"
            )
        ]
    }
}
