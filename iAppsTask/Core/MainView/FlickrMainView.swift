//
//  MainView.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 12/02/2025.
//

import SwiftUI

struct FlickrMainView: View {
    
    @State private var flickrFeed: [FlickrFeed] = FlickrFeed.mocks
    @State var viewModel: FlickrMainViewModel
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            ScrollView {
                VStack(alignment: .leading, spacing: 40){
                    ForEach(flickrFeed, id: \.id) { flickrFeed in
                        categorySection(feed: flickrFeed)
                    }
                }
            }
            .navigationDestinationForCoreModule(path: $viewModel.path)
        }
    }
    
    private func categorySection(feed: FlickrFeed) -> some View {
        VStack(alignment: .leading) {
            Text(feed.title)
                .font(.title)
                .fontWeight(.semibold)
            ZStack {
                ScrollView(.horizontal) {
                    HStack(spacing: 12) {
                        ForEach(feed.items, id: \.id) { flickrItem in
                            FeedCellView(
                                title: flickrItem.title,
                                imageName: flickrItem.link,
                                font: .caption
                            )
                            .anyButton {
                                viewModel.onFlickrItemPressed(flickrItem: flickrItem)
                            }
                        }
                    }
                }
                .padding()
                .withDividersAround()
                .frame(height: 140)
                .scrollIndicators(.hidden)
                .scrollTargetLayout()
                .scrollTargetBehavior(.viewAligned)
            }
        }
    }
}

#Preview {
    FlickrMainView(viewModel: FlickrMainViewModel())
}
