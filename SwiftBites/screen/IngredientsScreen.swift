import SwiftUI

struct IngredientsScreen: View {
    @State var searchedText: String = ""
    @State private var ingredients: [Ingredient] = Constants.IngredientConstants.initialIngredientList
    @State private var selectedIngredientIndex: Int = 0
    
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
            VStack {
                SearchView(searchedText: $searchedText)
                List(filteredIngredients) { ingredient in
                    NavigationLink {
                        AddIngredientView(name: ingredient.name)
                    } label: {
                        Text(ingredient.name)
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Ingredients")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddIngredientView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    IngredientsScreen()
}
