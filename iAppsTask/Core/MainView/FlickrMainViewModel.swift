//
//  FlickrMainViewModel.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 13/02/2025.
//

import Observation

@Observable
@MainActor
final class FlickrMainViewModel {
    
    var path: [NavigationPathOption] = []
    
    func onFlickrItemPressed(flickrItem: FlickrItem?) {
        path.append(.feedDetail(feedItem: flickrItem))
    }
}
