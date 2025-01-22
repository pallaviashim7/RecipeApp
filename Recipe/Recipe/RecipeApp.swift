//
//  RecipeApp.swift
//  Recipe
//
//  Created by Pallavi Ashim on 1/17/25.
//

import SwiftUI

@main
struct RecipeApp: App {
    
    init() {
        registerDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    func registerDependencies() {
        DIContainer.shared.register(type: NetworkProviding.self, dependecy: NetworkProvider())
        DIContainer.shared.register(type: URLConfigurable.self, dependecy: URLConfig())
        DIContainer.shared.register(type: ImageCachable.self, dependecy: ImageCacheManager())
    }
}
