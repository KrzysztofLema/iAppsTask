//
//  MainView.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 12/02/2025.
//

import SwiftUI

struct MainView: View {
    
    @State private var flickrFeed: [FlickrFeed] = FlickrFeed.mocks
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40){
                ForEach(flickrFeed, id: \.id) { flickrFeed in
                    categorySection(feed: flickrFeed)
                }
            }
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
            .removeListRowFormatting()
        }
    }
}

#Preview {
    MainView()
}
