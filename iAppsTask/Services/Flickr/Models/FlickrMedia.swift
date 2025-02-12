//
//  FlickrMedia.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 12/02/2025.
//

struct FlickrMedia: Codable, Hashable {
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url = "m"
    }
}
