//
//  iAppsTaskApp.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 12/02/2025.
//

import SwiftUI

@main
// swiftlint:disable:next type_name
struct iAppsTaskApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            FlickrMainView(
                viewModel: FlickrMainViewModel(
                    interactor: CoreInteractor(
                        container: delegate.dependencies.container
                    )
                )
            )
            .environment(delegate.dependencies.container)
        }
    }
}
