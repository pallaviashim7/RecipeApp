//
//  ContentView.swift
//  Recipe
//
//  Created by Pallavi Ashim on 1/17/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            RecipeListView(viewModel: RecipeListViewModel())
        }
    }

}

#Preview {
    ContentView()
}
