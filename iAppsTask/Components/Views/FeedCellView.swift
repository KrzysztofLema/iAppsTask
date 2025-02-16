//
//  FeedCellView.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 12/02/2025.
//

import SwiftUI

struct FeedCellView: View {
    var title: String = "Living the lifeasdasdasd"
    var imageURL: String = Constants.randomImage

    private let cellSize: CGFloat = switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            200
        case .phone:
            140
        default:
            100
    }

    private let imageSize: CGFloat = switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            140
        case .phone:
            80
        default:
            100
    }

    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                GridImageView(urlString: imageURL, size: imageSize)
                    .aspectRatio(1, contentMode: .fit)
                Text(title)
                    .adaptiveFont(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
            }
            .frame(width: cellSize, height: cellSize)
        }
    }
}

#Preview {
    FeedCellView()
        .frame(width: 150)
    FeedCellView()
        .frame(width: 300)
}
