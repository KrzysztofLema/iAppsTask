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

    var showPlayerView: Bool = false
    
    func onPlayerButtonPressed() {
        showPlayerView.toggle()
    }
    
    func onClosePlayerButtonPressed() {
        showPlayerView = false
    }
}



