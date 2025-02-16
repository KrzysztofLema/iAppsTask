//
//  MainView.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 12/02/2025.
//

import SwiftUI

struct FlickrMainView: View {
    
    @State var viewModel: FlickrMainViewModel
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            ScrollView {
                VStack(alignment: .leading, spacing: 40){
                    ForEach(viewModel.flickrFeed, id: \.id) { flickrFeed in
                        categorySection(feed: flickrFeed)
                    }
                }
            }
            .navigationDestinationForCoreModule(path: $viewModel.path)
            .onFirstTask {
                await viewModel.loadCatFeed()
            }
            .onFirstTask {
                await viewModel.loadDogFeed()
            }
            .onFirstTask {
                await viewModel.loadMoutainsFeed()
            }
            .onFirstTask {
                await viewModel.loadBoatsFeed()
            }
        }
    }
    
    private func categorySection(feed: FlickrFeed) -> some View {
        VStack(alignment: .leading) {
            Text(feed.title)
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(1)
            ZStack {
                ScrollView(.horizontal) {
                    HStack(spacing: 12) {
                        ForEach(feed.items, id: \.id) { flickrItem in
                            FeedCellView(
                                title: flickrItem.title,
                                imageURL: flickrItem.media.url,
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
    FlickrMainView(
        viewModel: FlickrMainViewModel(
            interactor: CoreInteractor(
                container: DevPreview.shared.container)
        )
    )
    .previewEnvironment()
}
