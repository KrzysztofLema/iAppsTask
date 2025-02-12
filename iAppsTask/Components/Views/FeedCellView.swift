//
//  FeedCellView.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 12/02/2025.
//

import SwiftUI

struct FeedCellView: View {
    var title: String = "Living the life"
    var imageName: String = Constants.randomImage
    var font: Font = .title2
    
    var body: some View {
        VStack {
            ImageLoaderView()
                .aspectRatio(1, contentMode: .fit)
            Text(title)
                .font(font)
                .fontWeight(.semibold)
                .lineLimit(1)
                .minimumScaleFactor(0.3)
        }
    }
}

#Preview {
    FeedCellView()
        .frame(width: 150)
    FeedCellView()
        .frame(width: 300)
}
