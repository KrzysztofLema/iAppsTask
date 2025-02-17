//
//  PlayerManager.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 17/02/2025.
//

import Foundation
import Observation

@Observable
@MainActor
class PlayerManager {
    private let service: PlayerServiceType
    weak var delegate: PlayerManagerDelegate?

    var currentTime: TimeInterval {
        service.currentTime
    }

    var duration: TimeInterval {
        service.duration
    }

    var isPlaying: Bool {
        service.isPlaying
    }

    var playerItem: PlayerItem? {
        service.playerItem
    }

    var playbackStatus: PlaybackStatus {
        if service.isPlaying {
            .playing
        } else {
            .paused
        }
    }

    private var timeObserverToken: Any?

    init(service: PlayerServiceType) {
        self.service = service
        setupTimeObserver()
    }

    deinit {
        Task { [self] in
            await removeTimeObserver()
        }
    }

    func play() {
        service.play()
        Task {
            await delegate?.playerManager(self, didChangePlaybackStatus: .playing)
        }
    }

    func pause() {
        service.pause()

        Task {
            await delegate?.playerManager(self, didChangePlaybackStatus: .paused)
        }
    }

    func seek(to time: TimeInterval) {
        service.seek(to: time) { [weak self] finished in
            guard let self else { return }
            if finished {
                Task {
                    await self.delegate?.playerManager(self, currentTime: time, duration: self.duration)
                }
            }
        }
    }

    func togglePlayback() {
        if isPlaying {
            pause()
        } else {
            play()
        }
    }

    private func setupTimeObserver() {
        let interval = TimeInterval(0.5)

        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            guard let self else { return }
            Task {
                await self.delegate?.playerManager(self, currentTime: self.currentTime, duration: self.duration)
            }
        }
    }

    private func removeTimeObserver() async {}
}
