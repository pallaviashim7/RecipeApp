//
//  RecipeListViewModel.swift
//  Recipe
//
//  Created by Pallavi Ashim on 1/19/25.
//

import Foundation

// View states
enum RecipeListState {
    case readyToStart
    case finished(Bool)
}

@MainActor
class RecipeListViewModel: ObservableObject {
    
    @Injected var networkProvider: NetworkProviding
    @Injected var urlConfig: URLConfigurable
    @Published var viewState: RecipeListState = .readyToStart
    
    var recipes: [Recipe] = []
    var cuisineList: [String] = []
    
    // MARK: Public
    
    /// This function fetch recipes from remote on call
    ///
    /// - Returns: Void.
    
    func fetchRecipes() {
        viewState = .readyToStart
        fetchDataFromRemote()
    }
    
    /// This function adds the image to cache
    /// - Parameters:
    ///   - selection: Selected cuisine type
    /// - Returns: [Recipe] Filtered recipe based on selected cuisine.
    
    func filteredRecipes(selection: String) -> [Recipe] {
        if selection == "All" {
            return recipes
        } else {
            return recipes.filter{$0.cuisine == selection}
        }
    }
    
    // MARK: - Private Methods
    
    private func getCuisines() -> [String] {
        let cuisines = self.recipes.map{ $0.cuisine }.uniqued()
        return ["All"] + cuisines.uniqued() // Append all to show all cuisines
    }
    
    private func fetchDataFromRemote() {
        Task {
            do {
                if let data = try await networkProvider.fetchDataFrom(urlString: urlConfig.remoteURL()) {
                    if let recipes = try? JSONDecoder().decode(RecipeData.self, from: data) {
                        self.recipes = recipes.recipes
                        self.cuisineList = getCuisines()
                        viewState = .finished(true)
                        return
                    }
                }
                viewState = .finished(false)
            } catch {
                print(error)
                viewState = .finished(false)
            }
        }
    }
    
    private func retrieveDate() async {
        do {
            if let data = try await networkProvider.fetchDataFrom(urlString: urlConfig.remoteURL()) {
                if let recipes = try? JSONDecoder().decode(RecipeData.self, from: data) {
                    self.recipes = recipes.recipes
                    self.cuisineList = getCuisines()
                }
            }
        } catch {
        
        }
    }
    
}
