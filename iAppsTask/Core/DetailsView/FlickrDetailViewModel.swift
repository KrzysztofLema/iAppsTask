//
//  FlickrDetailViewModel.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 13/02/2025.
//

import Observation

@Observable
@MainActor
final class FlickrDetailViewModelViewModel {
    
    private(set) var flicrkItem: FlickrItem = FlickrItem.mock
    
    var showPlayerView: Bool = false
    
    init(flicrkItem: FlickrItem) {
        self.flicrkItem = flicrkItem
    }
    
    func onPlayerButtonPressed() {
        showPlayerView.toggle()
    }
    
    func onClosePlayerButtonPressed() {
        showPlayerView = false
    }
}



