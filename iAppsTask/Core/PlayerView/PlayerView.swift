//
//  PlayerView.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 13/02/2025.
//

import SwiftUI

struct PlayerView: View {
    
    @State var viewModel: PlayerViewViewModel
    
    var body: some View {
        VStack {
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
            SliderView(progress: $viewModel.value)
        }
        .frame(height: viewModel.isPlayerExpanded ? 400 : 80)
        .onTapGesture {
            viewModel.isPlayerExpanded = true
        }
        .background(.white)
        .animation(.default, value: viewModel.isPlayerExpanded)
    }
}

#Preview {
    PlayerView(viewModel: PlayerViewViewModel())
}
