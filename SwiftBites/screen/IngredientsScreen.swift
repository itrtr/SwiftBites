//
//  IngredientsScreen.swift
//  SwiftBites
//
//  Created by Singh, Pankaj on 17/11/24.
//

import SwiftUI

struct IngredientsScreen: View {
    @State var searchedText: String = ""
    @State private var ingredients: [Ingredient] = Constants.IngredientConstants.initialIngredientList
    
    var filteredIngredients: [Ingredient] {
        if searchedText.isEmpty {
            return ingredients
        }
        return ingredients.filter { ingredient in
            ingredient.name.localizedCaseInsensitiveContains(searchedText)
        }
    }
    
    var body: some View {
        NavigationStack {
            SearchView(searchedText: $searchedText) // Search View
                .navigationTitle("Ingredients")
            
            List(filteredIngredients) { ingredient in
                NavigationLink {
                    
                } label: {
                    Text(ingredient.name)
                }
            }
            .listStyle(.plain)
            
            Spacer()
        }
    }
}

#Preview {
    IngredientsScreen()
}
