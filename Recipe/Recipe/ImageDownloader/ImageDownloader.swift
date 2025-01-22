//
//  ImageDownloader.swift
//  Recipe
//
//  Created by Pallavi Ashim on 1/21/25.
//

import SwiftUI

@MainActor
class ImageDownloader: ObservableObject {
    
    @Injected var networkProvider: NetworkProviding // Dependency for network call
    @Injected var cacheManager: ImageCachable // Dependency for caching image
    
    @Published var image: UIImage? 

    /// Use this function in the View to retrive image from cache or remote
    /// - Parameters:
    ///   - imageURL: Image url
    /// - Returns: Void.
    
    func getImage(imageURL: String) {
        if let savedImage = cacheManager.get(key: imageURL) {
            image = savedImage
        } else {
            downloadImage(imageURL: imageURL)
        }
    }
    
    // MARK: - Private methods
    
    /// Method to download image from remote
    private func downloadImage(imageURL: String) {
        Task {
            do {
                if let data = try await networkProvider.fetchDataFrom(urlString: imageURL) {
                    self.image = UIImage(data: data)
                    let imageKey = imageURL
                    self.cacheManager.add(key: imageKey, value: self.image ?? UIImage())
                }

            } catch {
                
            }

        }
    }
}
