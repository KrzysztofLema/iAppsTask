//
//  PlayerManagerTests.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 17/02/2025.
//

import Foundation
@testable import iAppsTask
import Testing

@MainActor
final class PlayerManagerTests {
    @Test("Initialization")
    func testInitialization() {
        let service = MockPlayerService()
        let manager = PlayerManager(service: service)

        #expect(manager.currentTime == 0)
        #expect(manager.duration == 100)
        #expect(manager.isPlaying == false)
        #expect(manager.playerItem == nil)
        #expect(manager.playbackStatus == .paused)
    }

    @Test("Play")
    func testPlay() async {
        let service = MockPlayerService()
        let manager = PlayerManager(service: service)

        manager.play()

        #expect(service.playCallCount == 1)
        #expect(service.isPlaying == true)
        #expect(manager.playbackStatus == .playing)
    }

    @Test("Pause")
    func testPause() async {
        let service = MockPlayerService()
        let manager = PlayerManager(service: service)

        manager.pause()

        #expect(service.pauseCallCount == 1)
        #expect(service.isPlaying == false)
        #expect(manager.playbackStatus == .paused)
    }

    @Test("Seek")
    func testSeek() async {
        let service = MockPlayerService()
        let manager = PlayerManager(service: service)

        let targetTime: TimeInterval = 50

        manager.seek(to: targetTime)

        #expect(service.seekCallCount == 1)
        #expect(service.seekTime == targetTime)
        #expect(service.currentTime == targetTime)
    }

    @Test("Toggle Playback - Play to Pause")
    func testTogglePlaybackFromPlayToPause() async {
        let service = MockPlayerService()
        let manager = PlayerManager(service: service)

        service.isPlaying = true

        manager.togglePlayback()

        #expect(service.pauseCallCount == 1)
        #expect(service.isPlaying == false)
        #expect(manager.playbackStatus == .paused)
    }

    @Test("Toggle Playback - Pause to Play")
    func testTogglePlaybackFromPauseToPlay() async {
        let service = MockPlayerService()
        let manager = PlayerManager(service: service)

        service.isPlaying = false

        manager.togglePlayback()

        #expect(service.playCallCount == 1)
        #expect(service.isPlaying == true)
        #expect(manager.playbackStatus == .playing)
    }
}
