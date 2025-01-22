//
//  RecipeListItem.swift
//  Recipe
//
//  Created by Pallavi Ashim on 1/18/25.
//

import SwiftUI

struct RecipeListItem: View {
    var recipe: Recipe
    @StateObject var imageDownloader = ImageDownloader()
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 10)
            Image(uiImage: imageDownloader.image ?? UIImage())
                .resizable()
                .frame(width: 50, height: 50)
                .scaledToFill()
                .cornerRadius(10)
            Text(recipe.name)
                .font(.system(size: 18))
                .padding()
                .minimumScaleFactor(0.01)

            Spacer()
            VStack {
                Spacer()
                    .frame(height: 5)
                Text(recipe.cuisine)
                    .font(.system(size: 20, weight: .semibold))
                Spacer()
            }
            Spacer()
                .frame(width: 15)
        }
        .frame(height: 100)
        .onAppear() {
            imageDownloader.getImage(imageURL: recipe.photoURLSmall)
        }
    }
}

struct RecipeListItem_Preview: PreviewProvider {
    static var previews: some View {
        RecipeListItem(recipe: Recipe(cuisine: "French", name: "Waffle", photoURLLarge: "photo", photoURLSmall: "photo", sourceURL: nil, id: UUID().uuidString, youtubeURL: nil))
            .previewLayout(.fixed(width: 500, height: 200))

    }
}
