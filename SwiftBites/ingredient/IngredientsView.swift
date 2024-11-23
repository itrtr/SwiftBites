//
//  IngredientsView.swift
//  SwiftBites
//
//  Created by Singh, Pankaj on 22/11/24.
//

import SwiftUI
import SwiftData

struct IngredientsView: View {
    var onItemSelected: ((Ingredient) -> Void)? = nil
    
    @State private var searchText: String = ""
    @State private var formMode: IngredientFormMode = .add
    @Query var ingredients: [Ingredient]
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var isNavigatingToForm: Bool = false
    
    // TODO:: Add use of #Predicate
    // Implement a search bar using a #Predicate to search ingredients by name.
    private var filteredIngredients: [Ingredient] {
        if searchText.isEmpty {
            return ingredients
        }
        return ingredients.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationStack {
            // We should show the search bar always unless the main ingredients list is empty
            if !ingredients.isEmpty {
                SearchView(searchedText: $searchText, placeholder: "Search Ingredients...")
            }
            
            if filteredIngredients.isEmpty {
                ContentNotFoundView(labelText: "No Ingredients Found",
                                    descriptionText: "Please add an ingredient to see here",
                                    systemImageName: "carrot.fill")
                
                NavigationLink(destination: IngredientForm(mode: .add)) {
                    VStack {
                        Image(systemName: "plus.circle.fill").font(.title)
                        Text("Add an ingredient")
                    }
                }
            } else {
                List {
                    ForEach(ingredients) { ingredient in
                        Button(action: {
                            if let onItemSelected = onItemSelected {
                                onItemSelected(ingredient)
                                dismiss()
                            } else {
                                formMode = .edit(ingredient)
                                isNavigatingToForm = true
                            }
                        }) {
                            HStack {
                                Text(ingredient.name)
                                Spacer()
                                if onItemSelected == nil {
                                    Image(systemName: "arrow.right") // Edit indicator
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            // Navigate to form in add mode
                            formMode = .add
                            isNavigatingToForm = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .navigationTitle("Ingredients")
                .navigationDestination(isPresented: $isNavigatingToForm) {
                    IngredientForm(mode: formMode)
                }
            }
        }
    }
    
    private func deleteIngredient(indexSet: IndexSet) {
    }
}

//#Preview {
//    IngredientsView()
//        .modelContainer(for: [Ingredient.self])
//}
