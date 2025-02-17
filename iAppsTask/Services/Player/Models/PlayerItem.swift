//
//  PlayerItem.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 17/02/2025.
//

import SwiftUI

struct PlayerItem: Identifiable {
    let id: UUID = .init()
    let title: String
    let artist: String
    let duration: TimeInterval
    let artworkName: String?

    static let mock = mockItems[0]

    static let mockItems = [
        PlayerItem(
            title: "Dreams",
            artist: "Fleetwood Mac",
            duration: 257,
            artworkName: nil
        ),
        PlayerItem(
            title: "Hotel California",
            artist: "Eagles",
            duration: 391,
            artworkName: nil
        ),
        PlayerItem(
            title: "Bohemian Rhapsody",
            artist: "Queen",
            duration: 354,
            artworkName: nil
        )
    ]
}
