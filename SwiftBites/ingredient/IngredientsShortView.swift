//
//  IngredientsShortView.swift
//  SwiftBites
//
//  Created by Singh, Pankaj on 23/11/24.
//

import SwiftUI

struct IngredientsShortView: View {
    @State var ingredients: [Ingredient]
    @State private var shouldLoadIngredientSheet: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Show existing ingredients or a placeholder view
            if !ingredients.isEmpty {
                ForEach(ingredients) { ingredient in
                    Text(ingredient.name)
                }
            } else {
                ContentNotFoundView(
                    labelText: "No Ingredients",
                    descriptionText: "Ingredients you will add appear here",
                    systemImageName: "list.clipboard"
                )
                .listRowBackground(Color.clear)
            }
            
            // Button to open IngredientsView
            Button {
                shouldLoadIngredientSheet = true
            } label: {
                Text("Add Ingredient").foregroundStyle(.blue)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .sheet(isPresented: $shouldLoadIngredientSheet) {
                NavigationStack {
//                    IngredientsView(onItemSelected: { selectedIngredient in
//                            // Append selected ingredient to the list
//                            ingredients.append(selectedIngredient)
//                            // Close the sheet after selection
//                            shouldLoadIngredientSheet = false
//                    }, ingredients: ingredients)
                    
                }.presentationDetents([.medium])
            }
        }
        .padding(.bottom, 10)
    }
}


//
//#Preview {
//    IngredientsShortView(ingredients: .constant([]))
//}
