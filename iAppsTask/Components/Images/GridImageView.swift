//
//  GridImageView.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 16/02/2025.
//

import SwiftUI

struct GridImageView: View {
    
    var urlString: String = "https://picsum.photos/600/600"
    var size: CGFloat = 100
    
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: size, height: size)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size, height: size)
            case .failure:
                Image(systemName: "photo")
                    .frame(width: size, height: size)
            @unknown default:
                Color.clear
                    .frame(width: size, height: size)
            }
        }
        .clipped()
        .frame(width: size, height: size)
        .contentShape(Rectangle())
    }
}
