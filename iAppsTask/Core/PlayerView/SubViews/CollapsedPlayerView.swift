//
//  CollapsedPlayerView.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 14/02/2025.
//

import SwiftUI

struct CollapsedPlayerView: View {
    var viewModel: PlayerViewViewModel

    var body: some View {
        contentView
    }

    private var contentView: some View {
        VStack {
            playerButtons
            Spacer()
            SliderView(
                currentTime: viewModel.currentTime,
                duration: viewModel.duration,
                onSeek: { newTime in
                    viewModel.seek(to: newTime, completion: { _ in

                    })
                }
            )
        }
        .frame(height: 80 - viewModel.dragOffset / 10)
    }

    private var playerButtons: some View {
        PlayerButtons(viewModel: viewModel)
    }
}
