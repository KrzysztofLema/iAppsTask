//
//  PlayerServiceType.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 17/02/2025.
//

import Foundation

protocol PlayerServiceType {
    func play()
    func pause()
    func seek(to time: TimeInterval, completion: ((Bool) -> Void)?)

    var playerItem: PlayerItem? { get }
    var currentTime: TimeInterval { get }
    var duration: TimeInterval { get }
    var isPlaying: Bool { get }
}

enum PlaybackStatus {
    case playing
    case paused
    case waiting
}

protocol PlayerManagerDelegate: AnyObject {
    func playerManager(_ manager: PlayerManager, didChangePlaybackStatus status: PlaybackStatus) async
    func playerManager(_ manager: PlayerManager, currentTime: TimeInterval, duration: TimeInterval) async
}
