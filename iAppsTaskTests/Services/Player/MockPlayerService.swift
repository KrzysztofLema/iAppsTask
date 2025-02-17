//
//  MockPlayerService 2.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 17/02/2025.
//

import Foundation
@testable import iAppsTask

class MockPlayerService: PlayerServiceType {
    var currentTime: TimeInterval = 0
    var duration: TimeInterval = 100
    var isPlaying: Bool = false
    var playerItem: PlayerItem?

    var playCallCount = 0
    var pauseCallCount = 0
    var seekCallCount = 0
    var seekTime: TimeInterval?

    func play() {
        isPlaying = true
        playCallCount += 1
    }

    func pause() {
        isPlaying = false
        pauseCallCount += 1
    }

    func seek(to time: TimeInterval, completion: ((Bool) -> Void)?) {
        seekCallCount += 1
        seekTime = time
        currentTime = time
        completion?(true)
    }
}
