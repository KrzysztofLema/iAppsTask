//
//  PlayerSupportView.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 13/02/2025.
//

import SwiftUI

struct PlayerSupportView<Content: View>: View {
    @Binding var showPlayer: Bool
    @ViewBuilder var content: Content

    var body: some View {
        ZStack {
            if showPlayer {
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .zIndex(1)
            }
        }
        .zIndex(9999)
        .animation(.bouncy, value: showPlayer)
    }
}

extension View {
    func showPlayer(showPlayer: Binding<Bool>, @ViewBuilder content: () -> some View) -> some View {
        overlay(alignment: .bottom) {
            PlayerSupportView(showPlayer: showPlayer) {
                content()
            }
        }
    }
}

private struct PreviewView: View {
    @State private var showPlayer: Bool = false
    @State private var showFullScreenPlayer: Bool = false

    var body: some View {
        Button("Click me") {
            showPlayer = true
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .showPlayer(showPlayer: $showPlayer) {
            Rectangle()
                .frame(height: 80)
                .frame(maxWidth: .infinity, alignment: .bottom)
                .onTapGesture {
                    showFullScreenPlayer = true
                }
                .transition(.move(edge: .bottom))
        }
    }
}

#Preview {
    PreviewView()
}
