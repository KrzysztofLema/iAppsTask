//
//  DependencyContainer.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 14/02/2025.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    var dependencies: Dependencies!

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        #if MOCK
            dependencies = Dependencies(config: .mock)
        #elseif DEV
            dependencies = Dependencies(config: .dev)
        #else
            dependencies = Dependencies(config: .prod)
        #endif

        return true
    }
}

enum BuildConfiguration {
    case mock, dev, prod
}

@MainActor
struct Dependencies {
    let container: DependencyContainer
    let logManager: LogManager

    init(config: BuildConfiguration) {
        let flickrManager: FlickrManager
        let playerManager: PlayerManager

        switch config {
            case .mock:
                self.logManager = LogManager(services: [])
                flickrManager = FlickrManager(service: MockFlickrService())
                playerManager = PlayerManager(service: MockPlayerService(playerItem: .mock))
            case .dev:
                self.logManager = LogManager(
                    services: [ConsoleService(printParameters: true)]
                )
                flickrManager = FlickrManager(service: FlickrService(serviceRequest: FlickrServiceRequest()))
                playerManager = PlayerManager(service: MockPlayerService(playerItem: .mock))
            case .prod:
                #warning("Production configuration not yet implemented")
                fatalError()
        }
        let container = DependencyContainer()
        container.register(FlickrManager.self, service: flickrManager)
        container.register(LogManager.self, service: logManager)
        container.register(PlayerManager.self, service: playerManager)
        self.container = container
    }
}

extension View {
    func previewEnvironment() -> some View {
        environment(DevPreview.shared.container)
    }
}

@MainActor
class DevPreview {
    static let shared = DevPreview()

    var container: DependencyContainer {
        let container = DependencyContainer()
        container.register(LogManager.self, service: logManager)
        container.register(FlickrManager.self, service: flickrManager)
        container.register(PlayerManager.self, service: playerManager)

        return container
    }

    let flickrManager: FlickrManager
    let logManager: LogManager
    let playerManager: PlayerManager

    init() {
        self.flickrManager = FlickrManager(service: MockFlickrService())
        self.logManager = LogManager(services: [])
        self.playerManager = PlayerManager(service: MockPlayerService(playerItem: .mock))
    }
}

@Observable
@MainActor
class DependencyContainer {
    private var services: [String: Any] = [:]

    func register<T>(_ type: T.Type, service: T) {
        let key = "\(type)"
        services[key] = service
    }

    func register<T>(_ type: T.Type, service: () -> T) {
        let key = "\(type)"
        services[key] = service()
    }

    func resolve<T>(_ type: T.Type) -> T? {
        let key = "\(type)"
        return services[key] as? T
    }
}
