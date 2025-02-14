//
//  PlayerViewModel.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 13/02/2025.
//

import Observation
import SwiftUI

@Observable
@MainActor
final class PlayerViewViewModel {
    
    var playerState: PlayerState = .collapsed
    var value: Float = 100
    var dragOffset: CGFloat = 0
    var onClosePressed: (() -> Void)?
    
    func onCloseButtonPressed() {
        onClosePressed?()
    }
    
    func updatePlayerStateBasedOnDragOffset() {
        guard playerState == .expanded || playerState == .collapsed else {
            return 
        }
        
        if playerState == .expanded, dragOffset > 5 {
            playerState = .collapsed
        } else if playerState == .collapsed, dragOffset < -5 {
            playerState = .expanded
        }
    }
    
    func updateDragOffset(_ offset: CGFloat) {
           dragOffset = offset
    }
    
    init(
        onClosePressed: (() -> Void)? = nil
    ) {
        self.onClosePressed = onClosePressed
    }
}

