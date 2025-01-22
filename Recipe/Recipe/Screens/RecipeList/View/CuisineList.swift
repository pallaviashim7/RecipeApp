//
//  CuisineList.swift
//  Recipe
//
//  Created by Pallavi Ashim on 1/22/25.
//

import SwiftUI

struct CuisineList: View {
    
    let cuisines: [String]
    @Binding var selectedCuisine: String
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(cuisines, id: \.self) { cuisine in
                Text(cuisine)
                    .frame(height: Layout.cusineListHeight)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(cuisine == selectedCuisine ? Color.red : Color.orange)
                    .cornerRadius(10)
                    .onTapGesture {
                        selectedCuisine = cuisine
                    }
            }
        }
    }
    
}
