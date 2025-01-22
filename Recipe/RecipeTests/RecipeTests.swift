//
//  RecipeTests.swift
//  RecipeTests
//
//  Created by Pallavi Ashim on 1/17/25.
//

import XCTest
import Combine
@testable import Recipe

final class RecipeTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func setUp() async throws {
        DIContainer.shared.register(type: NetworkProviding.self, dependecy: MockNetworkProvider())
        DIContainer.shared.register(type: URLConfigurable.self, dependecy: URLConfig())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Test recipe list view model, filter, cuisines and recipe count.

    @MainActor
    func testRecipeListViewModel() async throws {
        
        let expectation = XCTestExpectation(description: "Check for published values")

        let viewModel = RecipeListViewModel()
        var recipeCount = 0
        var cuisineCount = 0
        var filteredListCount = 0
        viewModel.$viewState.sink { state in
            switch state {
            case .readyToStart:
                break
            case .finished(_):
                recipeCount = viewModel.recipes.count
                cuisineCount = viewModel.cuisineList.count
                filteredListCount = viewModel.filteredRecipes(selection: "British").count
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        
        viewModel.fetchRecipes()
        await fulfillment(of: [expectation], timeout: 1.0)
        XCTAssertEqual(recipeCount, 3)
        XCTAssertEqual(cuisineCount, 3) // 2 + "All"
        XCTAssertEqual(filteredListCount, 2)
            
    }


}

struct MockNetworkProvider: NetworkProviding {
    func fetchDataFrom(urlString: String) async throws -> Data? {
        
        let mockResponse = """
{
  "recipes": [
    {
      "cuisine": "Malaysian",
      "name": "Apam Balik",
      "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
      "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
      "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
      "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
      "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
    },
    {
      "cuisine": "British",
      "name": "Apple & Blackberry Crumble",
      "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
      "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
      "source_url": "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
      "uuid": "599344f4-3c5c-4cca-b914-2210e3b3312f",
      "youtube_url": "https://www.youtube.com/watch?v=4vhcOwVBDO4"
    },
{
"cuisine": "British",
"name": "Apple Frangipan Tart",
"photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/large.jpg",
"photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/small.jpg",
"uuid": "74f6d4eb-da50-4901-94d1-deae2d8af1d1",
"youtube_url": "https://www.youtube.com/watch?v=rp8Slv4INLk"
}
  ]
}

"""
        let data = Data(mockResponse.utf8)
        return data
    }
}
