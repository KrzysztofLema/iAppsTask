//
//  ImageLoaderView.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 12/02/2025.
//

import SwiftUI

struct ImageLoaderView: View {
    var urlString: String = "https://picsum.photos/600/600"
    var resizingMode: ContentMode = .fill
    var opacity: Double = 1
    
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: resizingMode)
                .opacity(opacity)
                .allowsHitTesting(false)
        } placeholder: {
            ProgressView()
        }
        .clipped()
    }
}

#Preview {
    ImageLoaderView()
        .frame(width: 100, height: 200)
//        .anyButton(.highlight) {
//            
//        }
}
