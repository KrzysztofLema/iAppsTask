//
//  CollapsedPlayerView.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 14/02/2025.
//

import SwiftUI

struct CollapsedPlayerView: View {
    
    @Binding var viewModel: PlayerViewViewModel
    
    var body: some View {
          contentView
    }
    
    private var contentView: some View {
        VStack {
            playerButtons
            Spacer()
            SliderView(progress: $viewModel.value)
        }
        .frame(height: 80 - viewModel.dragOffset / 10)
    }
    
    private var playerButtons: some View {
        HStack {
            Image(systemName: "backward.circle")
                .font(.title)
                .anyButton {
                    
                }
            Image(systemName: "play.circle")
                .font(.title)
                .anyButton {
                    
                }
            Image(systemName: "forward.circle")
                .font(.title)
                .anyButton {
                    
                }
        }
        .frame(maxHeight: .infinity)
    }
}
