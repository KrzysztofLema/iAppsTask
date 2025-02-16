//
//  FlickrDetailViewModel.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 13/02/2025.
//
import Observation
import SwiftUI

@Observable
final class FlickrDetailViewModel {
    let flickrItem: FlickrItem
    var showPlayerView = false
    var scrollOffset: CGFloat = 0
    var imageHeight: CGFloat = 0
    var toolbarHeight: CGFloat = 0

    init(flickrItem: FlickrItem) {
        self.flickrItem = flickrItem
    }

    var takenDate: String {
        flickrItem.dateTaken.formattedString()
    }

    var publishedDate: String {
        flickrItem.published.formattedString()
    }

    func onPlayerButtonPressed() {
        showPlayerView.toggle()
    }

    func onClosePlayerButtonPressed() {
        showPlayerView = false
    }
}
