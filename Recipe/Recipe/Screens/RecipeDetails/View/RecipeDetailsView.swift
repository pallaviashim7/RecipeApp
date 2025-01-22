//
//  RecipeDetailsView.swift
//  Recipe
//
//  Created by Pallavi Ashim on 1/19/25.
//

import SwiftUI
import WebKit

struct RecipeDetailsView: View {
    
    let recipe: Recipe
    
    @StateObject var imageDownloader = ImageDownloader()

    var body: some View {
        VStack(alignment: .leading) {
            Image(uiImage: imageDownloader.image ?? UIImage())
                .resizable()
                .scaledToFit()
                .frame(height: 300)
            Text(recipe.name)
            Divider()
            if let youtubeURL = recipe.youtubeURL, let url = URL(string: youtubeURL) {
                NavigationLink {
                    WebView(url)
                } label: {
                    Text("Watch Recipe")
                }
            }
            
            if let sourceURL = recipe.youtubeURL, let url = URL(string: sourceURL) {
                Link("Go To full site", destination: url)
            }
            Spacer()
        }
        .padding()
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            imageDownloader.getImage(imageURL: recipe.photoURLLarge)
        }
    }
}


#Preview {
    RecipeDetailsView(recipe: Recipe(cuisine: "French", name: "Waffle", photoURLLarge: "photo", photoURLSmall: "photo", sourceURL: nil, id: UUID().uuidString, youtubeURL: nil))
}
