//
//  DetailView.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 13/02/2025.
//

import SwiftUI

struct FlickrDetailView: View {
    
    @State private var flicrkItem: FlickrItem = FlickrItem.mock
    @State private var scrollOffset: CGFloat = 0
    
    @State var viewModel: FlickrDetailViewModelViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { proxy in
                ImageLoaderView(opacity: calculateImageOpacity(for: scrollOffset))
                    .frame(width: proxy.size.width, height: 400)
            }
            
            ScrollView {
                GeometryReader { proxy in
                    Color.clear.preference(
                        key: ScrollOffsetKey.self,
                        value: proxy.frame(in: .global).minY
                    )
                }
                Spacer()
                    .frame(height: 400)
                VStack(alignment: .leading, spacing: 12) {
                    Text(flicrkItem.title)
                        .font(.title)
                        .bold()
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(alignment: .lastTextBaseline) {
                                Text("Author:")
                                Text(flicrkItem.author)
                                    .font(.headline)
                            }
                            
                            HStack(alignment: .lastTextBaseline) {
                                Text("Date taken:")
                                Text(flicrkItem.dateTaken, style: .date)
                                    .font(.headline)
                            }
                            
                            HStack(alignment: .lastTextBaseline) {
                                Text("Date published:")
                                Text(flicrkItem.published, style: .date)
                                    .font(.headline)
                            }
                        }
                        
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    
                }
                .padding()
            }
        }
        .toolbar(content: {
            ToolbarItemGroup(placement: .bottomBar) {
                HStack(spacing: 20) {
                    Text("Home")
                        .anyButton {
                            dismiss()
                        }
                    Text("Audio")
                        .anyButton {
                            viewModel.onPlayerButtonPressed()
                        }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        })
        .showPlayer(showPlayer: $viewModel.showPlayerView, content: {
            PlayerView(viewModel: PlayerViewViewModel())
                .frame(maxHeight: .infinity, alignment: .bottom)
                .offset(y: -80)
        })
        .scrollIndicators(.hidden)
        .ignoresSafeArea(edges: .top)
        .frame(maxHeight: .infinity, alignment: .top)
        .onPreferenceChange(ScrollOffsetKey.self) { value in
            scrollOffset = -value
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func calculateImageOpacity(for offset: CGFloat) -> Double {
        let startFade: CGFloat = 50
        let endFade: CGFloat = 200
        let minOpacity: Double = 0.7
        
        if offset < startFade {
            return 1.0
        } else if offset > endFade {
            return minOpacity
        } else {
            let fadeProgress = (offset - startFade) / (endFade - startFade)
            return max(minOpacity, 1.0 - fadeProgress)
        }
    }
}

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    FlickrDetailView(viewModel: FlickrDetailViewModelViewModel())
}
