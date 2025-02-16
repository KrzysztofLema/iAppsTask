//
//  FlickrMainView.swift
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
                VStack(alignment: .leading) {
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
                .adaptiveFont(.title2)
                .lineLimit(1)

            ScrollView(.horizontal) {
                HStack {
                    ForEach(feed.items, id: \.id) { flickrItem in
                        FeedCellView(
                            title: flickrItem.title,
                            imageURL: flickrItem.media.url
                        )
                        .anyButton {
                            viewModel.onFlickrItemPressed(flickrItem: flickrItem)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .scrollTargetLayout()
            .scrollTargetBehavior(.viewAligned)
        }
        .withDividersAround()
    }
}

#Preview {
    FlickrMainView(
        viewModel: FlickrMainViewModel(
            interactor: CoreInteractor(
                container: DevPreview.shared.container
            )
        )
    )
    .previewEnvironment()
}
