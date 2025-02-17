//
//  SliderView.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 13/02/2025.
//

import SwiftUI
struct SliderView: View {
    @State private var isDragging: Bool = false

    var currentTime: TimeInterval = 0
    var duration: TimeInterval = 0
    var onSeek: (TimeInterval) -> Void = { _ in }

    var progressBarMinHeight: CGFloat = 8
    var progressBarMaxHeight: CGFloat = 16

    private var progress: Double {
        guard duration > 0 else { return 0 }
        return (currentTime / duration) * 100
    }

    var body: some View {
        GeometryReader { proxy in
            progressBar(with: proxy)
                .gesture(
                    dragGestureRecognizer(with: proxy)
                )
        }
        .frame(height: isDragging ? progressBarMaxHeight : progressBarMinHeight)
    }

    private func progressBar(with proxy: GeometryProxy) -> some View {
        ZStack {
            bottomProgressBar
            topProgressBar(with: proxy)
        }
    }

    private var bottomProgressBar: some View {
        Rectangle()
            .foregroundStyle(.black.opacity(0.25))
            .frame(maxWidth: .infinity)
    }

    private func topProgressBar(with proxy: GeometryProxy) -> some View {
        Rectangle()
            .foregroundStyle(.blue)
            .frame(width: proxy.size.width * CGFloat(progress / 100))
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func dragGestureRecognizer(with proxy: GeometryProxy) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                isDragging = true
                let percentage = min(max(0, Float(value.location.x / proxy.size.width * 100)), 100)
                let seekTime = TimeInterval(Double(percentage) / 100.0 * duration)
                onSeek(seekTime)
            }
            .onEnded { _ in
                isDragging = false
            }
    }
}
