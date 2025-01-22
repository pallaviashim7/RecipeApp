//
//  ImageCacheManager.swift
//  Recipe
//
//  Created by Pallavi Ashim on 1/21/25.
//

import Foundation
import SwiftUI

protocol ImageCachable {
    
    /// This function adds the image to cache
    /// - Parameters:
    ///   - key: Key is set to be the image url.
    ///   - value: Going to be the downloaded image.
    /// - Returns: Void.
    func add(key: String, value: UIImage)
    
    /// This function retrives the saved image from image cache
    /// - Parameters:
    ///   - key: Pass in the image url to get the image
    /// - Returns: UIImage.
    func get(key: String) -> UIImage?
}

struct ImageCacheManager: ImageCachable {
        
    var photoCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200 // Set to clear cache once the limit is reached
        cache.totalCostLimit = 1024 * 1024 * 200 // 200mb
        return cache
    }()
    
    func add(key: String, value: UIImage) {
        photoCache.setObject(value, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage? {
        return photoCache.object(forKey: key as NSString)
    }
    
}
