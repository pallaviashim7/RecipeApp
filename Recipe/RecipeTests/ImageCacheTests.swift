//
//  Untitled.swift
//  Recipe
//
//  Created by Pallavi Ashim on 1/22/25.
//


import XCTest
import Combine
@testable import Recipe

final class ImageCacheTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() async throws {
        DIContainer.shared.register(type: NetworkProviding.self, dependecy: MockImageNetworkProvider())
        DIContainer.shared.register(type: URLConfigurable.self, dependecy: URLConfig())
        DIContainer.shared.register(type: ImageCachable.self, dependecy: MockImageCache())

    }
    
    
    // Test image downloading and saving to cache
    
    @MainActor
    func testRecipeListViewModel() async throws {
        
        let expectation = XCTestExpectation(description: "Check for published values")
        
        let imageDownloader = ImageDownloader()
        var downloadedImage: UIImage?
        imageDownloader.$image.sink { image in
            downloadedImage = image
            if image != nil {
                expectation.fulfill()
            }
            
        }.store(in: &cancellables)
        
        imageDownloader.getImage(imageURL: "SomeURL")
        
        await fulfillment(of: [expectation], timeout: 2.0)

        XCTAssertEqual(downloadedImage, MockImageContainer.image)

    }
}

struct MockImageContainer {
    static var image: UIImage?
}

struct MockImageCache: ImageCachable {
    func add(key: String, value: UIImage) {
        MockImageContainer.image = value
    }
    
    func get(key: String) -> UIImage? {
        return MockImageContainer.image
    }
    
    
}


struct MockImageNetworkProvider: NetworkProviding {
    func fetchDataFrom(urlString: String) async throws -> Data? {
        if let image = UIImage(systemName: "photo") {
            return image.pngData()
        } else {
            return nil
        }

    }
}

