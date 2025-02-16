//
//  FlickrDetailImageView.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 16/02/2025.
//

import SwiftUI

struct FlickrDetailImageView: View {
    
    let proxy: GeometryProxy
    
    var viewModel: FlickrDetailViewModel
    
    @Binding var scrollOffset: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: viewModel.flickrItem.media.url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: proxy.size.height * 0.6)
                    .overlay(content: {
                        Color.black.opacity(calculateImageOpacity(for: viewModel.scrollOffset))
                    })
                    .background(
                        GeometryReader { imageProxy in
                            Color
                                .clear
                                .preference(key: ImageHeightPreferenceKey.self, value: imageProxy.size.height)
                                }
                )
            case .failure:
                Image(systemName: "photo")
                    .frame(width: UIScreen.main.bounds.width, height: proxy.size.height * 0.6)
            @unknown default:
                Color.clear
                    .frame(width: UIScreen.main.bounds.width, height: proxy.size.height * 0.6)
            }
        }
        .clipped()
        .contentShape(Rectangle())
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
