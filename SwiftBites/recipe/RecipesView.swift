//
//  RecipesView.swift
//  SwiftBites
//
//  Created by Singh, Pankaj on 23/11/24.
//

import SwiftUI
import SwiftData

struct RecipesView: View {
    @Query var recipes: [Recipe]
    @State var option: RecipeSortOption = .name
    @State var searchedText: String = ""
    @State var isNavigatingToForm: Bool = false
    @State var formMode: RecipeFormMode = .add
    
    var filteredRecipes: [Recipe] {
        if searchedText.isEmpty {
            return recipes
        }
        return recipes.filter { recipe in
            recipe.title.localizedCaseInsensitiveContains(searchedText)
        }
    }
    
    var sortedAndFilteredRecipes: [Recipe] {
        let filtered = filteredRecipes
        switch option {
        case .name:
            return filtered.sorted { $0.title < $1.title }
        case .servingAscending:
            return filtered.sorted { $0.servingCount < $1.servingCount }
        case .servingDescending:
            return filtered.sorted { $0.servingCount > $1.servingCount }
        case .timeAscending:
            return filtered.sorted { $0.servingTime < $1.servingTime }
        case .timeDescending:
            return filtered.sorted { $0.servingTime > $1.servingTime }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                SearchView(searchedText: $searchedText) // Search View
                
                List(sortedAndFilteredRecipes, id: \.self) { recipe in
                    Button {
                        isNavigatingToForm = true
                        formMode = .edit(recipe)
                    } label: {
                        VStack(alignment: .leading) {
                            RecipeCell(recipe: recipe)
                            TagView(categoryName: recipe.category?.name ?? "None", servingSize: recipe.servingCount, servingTime: recipe.servingTime)
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        RecipeSortModalView(selectedSortOption: $option) // Modal View
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        RecipeForm(mode: .add)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(isPresented: $isNavigatingToForm) {
                RecipeForm(mode: formMode)
            }
        }
    }
}
