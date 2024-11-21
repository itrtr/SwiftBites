import SwiftUI

struct RecipesScreen: View {
    @State var recipes: [Recipe]
    @State var option: RecipeSortOption = .name
    @State var searchedText: String = ""
    
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
                    NavigationLink {
                        RecipeDetailView(recipe: recipe)
                    } label: {
                        RecipeShortView(recipe: recipe)
                    }
                    // TODO:: Remove chevron from the RecipeShortView
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
                        AddRecipeView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    let recipes = [
        Recipe(title: "Classic Margherita Pizza", detail: "A simple yet delicious pizza with tomato, mozzarella, basil, and olive oil.", servingCount: 4, servingTime: 120, tags: [
            Tag(image: "star", text: "Featured"),
            Tag(image: "tag", text: "Sale"),
            Tag(image: "flame", text: "Hot")
        ]),
        Recipe(title: "Spaghetti Carbonara", detail: "A classic Italian pasta dish made with eggs, cheese, pacetta, and pepper.", servingCount: 3, servingTime: 90, tags: [
            Tag(image: "star", text: "Featured"),
            Tag(image: "tag", text: "Sale"),
            Tag(image: "flame", text: "Hot")
        ]),
        Recipe(title: "ASpaghetti Carbonara", detail: "A classic Italian pasta dish made with eggs, cheese, pacetta, and pepper.", servingCount: 5, servingTime: 100, tags: [
            Tag(image: "star", text: "Featured"),
            Tag(image: "tag", text: "Sale"),
            Tag(image: "flame", text: "Hot")
        ])
    ]
    RecipesScreen(recipes: recipes)
}
