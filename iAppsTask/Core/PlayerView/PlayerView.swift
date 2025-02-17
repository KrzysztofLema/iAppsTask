//
//  PlayerView.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 13/02/2025.
//

import SwiftUI

struct PlayerView: View {
    @State var viewModel: PlayerViewViewModel
    @Namespace var namespace
    
    var body: some View {
        contentView
    }

    private var contentView: some View {
        ZStack {
            if viewModel.playerState == .expanded {
                darkBackgroundOpacity
            }
            ZStack {
                switch viewModel.playerState {
                    case .expanded:
                        expandedPlayerView
                    case .collapsed:
                        collapsedPlayerView
                }
            }
            .animation(.spring(), value: viewModel.playerState)
            .gesture(dragGesture)
            .zIndex(1)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }

    private var collapsedPlayerView: some View {
        CollapsedPlayerView(viewModel: viewModel, namespace: namespace)
            .contentShape(Rectangle())
    }

    private var expandedPlayerView: some View {
        ExpandedPlayerView(viewModel: viewModel, namespace: namespace)
            .contentShape(Rectangle())
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                viewModel.updateDragOffset(value.translation.height)
            }
            .onEnded { _ in
                viewModel.updatePlayerStateBasedOnDragOffset()
                viewModel.dragOffset = 0
            }
    }

    private var darkBackgroundOpacity: some View {
        Color
            .black
            .opacity(0.5)
            .ignoresSafeArea()
            .zIndex(0)
    }
}

#Preview("Collapsed") {
    PlayerView(
        viewModel: PlayerViewViewModel(
            interactor: CoreInteractor(
                container: DevPreview.shared.container
            ),
            playerState: .collapsed,
            dragOffset: 0
        )
    )
    .previewEnvironment()
}

#Preview("Expanded") {
    PlayerView(
        viewModel: PlayerViewViewModel(
            interactor: CoreInteractor(
                container: DevPreview.shared.container
            ),
            playerState: .expanded,
            dragOffset: 0
        )
    )
    .previewEnvironment()
}
