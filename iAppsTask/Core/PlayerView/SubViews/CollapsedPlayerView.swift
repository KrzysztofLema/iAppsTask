//
//  CollapsedPlayerView.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 14/02/2025.
//

import SwiftUI

struct CollapsedPlayerView: View {
    
    var viewModel: PlayerViewViewModel
    var namespace: Namespace.ID

    var body: some View {
        contentView
    }

    private var contentView: some View {
        VStack {
            playerButtons
                .matchedGeometryEffect(id: "playerButtons", in: namespace)
            SliderView(
                currentTime: viewModel.currentTime,
                duration: viewModel.duration,
                onSeek: { newTime in
                    viewModel.seek(to: newTime, completion: { _ in

                    })
                }
            )
            .matchedGeometryEffect(id: "slider", in: namespace)
        }
        .background(Color(uiColor: UIColor.secondarySystemBackground))
        .frame(height: 80 - viewModel.dragOffset / 10)
    }

    private var playerButtons: some View {
        PlayerButtons(viewModel: viewModel)
    }
}

#Preview {
    CollapsedPlayerView(
        viewModel: PlayerViewViewModel(
            interactor: CoreInteractor(
                container: DevPreview.shared.container)),
        namespace: Namespace().wrappedValue
    )
}
