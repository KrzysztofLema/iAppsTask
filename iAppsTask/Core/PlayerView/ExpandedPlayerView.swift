//
//  ExpandedPlayerView.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 14/02/2025.
//

import SwiftUI

struct ExpandedPlayerView: View {
    
    @Binding var viewModel: PlayerViewViewModel
    
    var body: some View {
        contentView
    }
    
    private var contentView: some View {
        VStack(alignment: .leading) {
            headerView
            descriptionView
            playerButtons
            Spacer()
            SliderView(progress: $viewModel.value)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .frame(height: 400 - viewModel.dragOffset / 10)
    }
    
    private var headerView: some View {
        ZStack {
            dragIndication
            HStack {
                Spacer()
                closeButton
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private var descriptionView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("An Audio Title")
                .font(.title)
                .fontWeight(.bold)
                .lineLimit(1)
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non")
                .lineLimit(8)
                .multilineTextAlignment(.leading)
                .minimumScaleFactor(0.8)
        }
        .padding(.top, 16)
        .padding()
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
        .frame(maxWidth: .infinity)
    }
    
    private var dragIndication: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(Color.black.opacity(0.6))
            .frame(width: 80, height: 10)
    }
    
    private var closeButton: some View {
        Image(systemName: "xmark.app.fill")
            .font(.title)
            .padding(6)
            .anyButton {
                viewModel.onCloseButtonPressed()
            }
    }
}
