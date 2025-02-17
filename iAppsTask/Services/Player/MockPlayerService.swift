//
//  MockPlayerService.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 17/02/2025.
//

import Foundation
import Observation

@Observable
final class MockPlayerService: PlayerServiceType {
    var currentTime: TimeInterval = 30
    var duration: TimeInterval = 180
    var isPlaying: Bool = false

    var playerItem: PlayerItem?

    private var timer: Timer?

    init(playerItem: PlayerItem) {
        self.playerItem = playerItem
        self.duration = playerItem.duration
    }

    func play() {
        isPlaying = true
        startPlaybackTimer()
    }

    func pause() {
        isPlaying = false
        stopPlaybackTimer()
    }

    func seek(to time: TimeInterval, completion: ((Bool) -> Void)?) {
        currentTime = min(max(0, time), duration)
        completion?(true)
    }

    private func startPlaybackTimer() {
        stopPlaybackTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self else { return }
            DispatchQueue.main.async {
                self.currentTime = min(self.currentTime + 1, self.duration)
                if self.currentTime >= self.duration {
                    self.pause()
                    self.currentTime = 0
                }
            }
        }
    }

    private func stopPlaybackTimer() {
        timer?.invalidate()
        timer = nil
    }

    deinit {
        stopPlaybackTimer()
    }
}
