//
//  NavigationPathOption.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 13/02/2025.
//

import Foundation
import SwiftUI

enum NavigationPathOption: Hashable {
    case feedDetail(feedItem: FlickrItem)
}

struct NavDestinationForCoreModuleViewModifier: ViewModifier {
    let path: Binding<[NavigationPathOption]>

    func body(content: Content) -> some View {
        content
            .navigationDestination(for: NavigationPathOption.self) { newValue in
                switch newValue {
                    case let .feedDetail(feedItem: feedItem):
                        FlickrDetailView(viewModel: FlickrDetailViewModel(flickrItem: feedItem))
                }
            }
    }
}

extension View {
    func navigationDestinationForCoreModule(path: Binding<[NavigationPathOption]>) -> some View {
        modifier(NavDestinationForCoreModuleViewModifier(path: path))
    }
}
