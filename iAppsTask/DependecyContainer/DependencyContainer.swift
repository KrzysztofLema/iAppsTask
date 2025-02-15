//
//  DependencyContainer.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 14/02/2025.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    var dependencies: Dependencies!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        dependencies = Dependencies()
        
        return true
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


@MainActor
struct Dependencies {
    
    let container: DependencyContainer
    let flickrManager: FlickrManager
    
    init() {
        let container = DependencyContainer()
        
        self.flickrManager = FlickrManager(service: FlickrService(serviceRequest: FlickrServiceRequest()))
        
        container.register(FlickrManager.self, service: flickrManager)
        self.container = container
    }
}

extension View {
    func previewEnvironment() -> some View {
        self
            .environment(DevPreview.shared.container)
    }
}

@MainActor
class DevPreview {
    static let shared = DevPreview()
    
    var container: DependencyContainer {
        let container = DependencyContainer()
        container.register(NetworkManagerType.self, service: networManager)
        container.register(FlickrManager.self, service: flickrManager)
        return container
    }
    
    let networManager: NetworkManagerType
    let flickrManager: FlickrManager
    
    init() {
        self.networManager = MockNetworkManager(mockData: .some(Data()))
        self.flickrManager = FlickrManager(service: MockFlickrService())
    }
}
