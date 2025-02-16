//
//  DetailView.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 13/02/2025.
//

import SwiftUI

struct FlickrDetailView: View {

    @State var viewModel: FlickrDetailViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { proxy in
                FlickrDetailImageView(
                    proxy: proxy,
                    viewModel: viewModel,
                    scrollOffset: $viewModel.scrollOffset
                )
            }
            
            ScrollView {
                GeometryReader { geometry in
                    Color.clear
                        .preference(
                            key: ScrollOffsetKey.self,
                            value: -geometry.frame(in: .global).minY
                        )
                }
                Spacer()
                    .frame(height: viewModel.imageHeight)
                VStack(alignment: .leading, spacing: 12) {
                    Text(viewModel.flickrItem.title)
                        .font(.title)
                        .bold()
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(alignment: .lastTextBaseline) {
                                Text("Author:")
                                Text(viewModel.flickrItem.author)
                                    .font(.headline)
                                    .lineLimit(1)
                            }
                            
                            HStack(alignment: .lastTextBaseline) {
                                Text("Date taken:")
                                Text(
                                    viewModel.flickrItem.dateTaken,
                                    style: .date
                                )
                                .font(.headline)
                                .lineLimit(1)
                            }
                            
                            HStack(alignment: .lastTextBaseline) {
                                Text("Date published:")
                                Text(
                                    viewModel.flickrItem.published,
                                    style: .date
                                )
                                .font(.headline)
                                .lineLimit(1)
                            }
                        }
                        
                        Text(String.loremIpsum(paragraphs: 3))
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    
                }
                .padding()
            }
        }
        .onPreferenceChange(ScrollOffsetKey.self) { value in
            viewModel.scrollOffset = value
        }
        .onPreferenceChange(ImageHeightPreferenceKey.self) { newHeight in
            viewModel.imageHeight = newHeight
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
                .measureToolbarHeight(height: $viewModel.toolbarHeight)
            }
        })
        .showPlayer(
            showPlayer: $viewModel.showPlayerView,
            content: {
                PlayerView(
                    viewModel: PlayerViewViewModel(
                        onClosePressed: {
                            viewModel.onClosePlayerButtonPressed()
                        }
                    )
                )
                .offset(y: -viewModel.toolbarHeight)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .transition(
                   .asymmetric(
                       insertion: .move(edge: .bottom).combined(with: .opacity),
                       removal: .move(edge: .bottom).combined(with: .opacity)
                   ))
            })
        .animation(.default, value: viewModel.showPlayerView)
        .scrollIndicators(.hidden)
        .frame(maxHeight: .infinity, alignment: .top)
        .toolbar(.hidden, for: .navigationBar)
        .ignoresSafeArea()
    }
    
    private func calculateImageOpacity(for offset: CGFloat) -> Double {
         let startFade: CGFloat = 50
         let endFade: CGFloat = 200
         let maxOpacity: Double = 0.7
         
         if offset < startFade {
             return 0.0
         } else if offset > endFade {
             return maxOpacity
         } else {
             let fadeProgress = (offset - startFade) / (endFade - startFade)
             return min(maxOpacity, fadeProgress * maxOpacity)
         }
     }
}

#Preview {
    FlickrDetailView(viewModel: FlickrDetailViewModel(flickrItem: .mock))
}
