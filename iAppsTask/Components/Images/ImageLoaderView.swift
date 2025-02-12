//
//  ImageLoaderView.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 12/02/2025.
//

import SwiftUI

struct ImageLoaderView: View {
    var urlString: String = Constants.randomImage
    var resizingMode: ContentMode = .fill
    
    var body: some View {
        Rectangle()
            .opacity(0.0001)
            .overlay {
                AsyncImage(url: URL(string: urlString), content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: resizingMode)
                        .allowsHitTesting(false)
                }, placeholder: {
                    ProgressView()
                })
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
