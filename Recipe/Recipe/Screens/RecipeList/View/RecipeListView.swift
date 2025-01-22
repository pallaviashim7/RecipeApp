//
//  RecipeListView.swift
//  Recipe
//
//  Created by Pallavi Ashim on 1/18/25.
//

import SwiftUI

struct RecipeListView: View {
    
    @StateObject var viewModel: RecipeListViewModel
    @State var selectedCuisine: String = "All"
    var body: some View {
        ZStack {
            switch viewModel.viewState {
            case .readyToStart:
                Text("Starting")
            case .finished(let finished):
                let recipeList = viewModel.filteredRecipes(selection: selectedCuisine)
                if finished {
                    if !recipeList.isEmpty {
                        VStack {
                            Spacer()
                                .frame(height: 10)
                            ScrollView(.horizontal) {
                                CuisineList(cuisines: viewModel.cuisineList, selectedCuisine: $selectedCuisine)
                            }
                            .frame(height: Layout.cusineListHeight)
                            
                            List(recipeList) { recipe in
                                    NavigationLink {
                                        RecipeDetailsView(recipe: recipe)
                                    } label: {
                                        RecipeListItem(recipe: recipe)
                                    }
                            }
                            .listRowSpacing(20)
                        }
                    } else {
                        Text("No Recipes available at the moment")
                    }
                    
                } else {
                    Text("Error")
                }
                
            }
        }
        .onAppear() {
            viewModel.fetchRecipes()
        }
        .navigationTitle("Recipes")
        
    }
}


#Preview {
    RecipeListView(viewModel: RecipeListViewModel())
}
