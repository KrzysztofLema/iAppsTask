//
//  PlayerViewModel.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 13/02/2025.
//

import Observation
import SwiftUI

protocol PlayerViewModelInteractor {
    var currentTime: TimeInterval { get }
    var duration: TimeInterval { get }
    var isPlaying: Bool { get }
    var playbackStatus: PlaybackStatus { get }
    var playerItem: PlayerItem? { get }

    func play()
    func pause()
    func seek(to time: TimeInterval, completion: ((Bool) -> Void)?)
}

extension CoreInteractor: PlayerViewModelInteractor {}

@Observable
@MainActor
final class PlayerViewViewModel {
    private let interactor: PlayerViewModelInteractor

    var currentTime: TimeInterval {
        interactor.currentTime
    }

    var duration: TimeInterval {
        interactor.duration
    }

    var isPlaying: Bool {
        interactor.isPlaying
    }

    var playbackStatus: PlaybackStatus {
        interactor.playbackStatus
    }

    var playerItem: PlayerItem? {
        interactor.playerItem
    }

    var playerState: PlayerState = .collapsed
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

    func onPlayButtonTapped() {
        if interactor.isPlaying {
            interactor.pause()
        } else {
            interactor.play()
        }
    }

    func seek(to time: TimeInterval, completion: ((Bool) -> Void)?) {
        interactor.seek(to: time, completion: completion)
    }

    init(
        interactor: PlayerViewModelInteractor,
        playerState: PlayerState = .collapsed,
        dragOffset: CGFloat = 0,
        onClosePressed: (() -> Void)? = nil
    ) {
        self.interactor = interactor
        self.playerState = playerState
        self.dragOffset = dragOffset
        self.onClosePressed = onClosePressed
    }
}
