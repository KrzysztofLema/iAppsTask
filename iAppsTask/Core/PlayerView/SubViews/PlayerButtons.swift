//
//  PlayerButtons.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 17/02/2025.
//

import SwiftUI

struct PlayerButtons: View {
    var viewModel: PlayerViewViewModel

    var body: some View {
        HStack {
            Image(systemName: "backward.circle")
                .font(.title)
                .anyButton {}
            Image(systemName: viewModel.isPlaying ? "pause.circle" : "play.circle")
                .font(.title)
                .anyButton {
                    viewModel.onPlayButtonTapped()
                }
            Image(systemName: "forward.circle")
                .font(.title)
                .anyButton {}
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    PlayerButtons(
        viewModel: PlayerViewViewModel(
            interactor: CoreInteractor(
                container: DevPreview.shared.container
            )
        )
    )
}
