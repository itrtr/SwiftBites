import SwiftUI
import SwiftData

struct IngredientsScreen: View {
    private var ingredients: [Ingredient]
    
    @State var searchedText: String = ""
    @State private var selectedIngredientIndex: Int = 0
    
    @Environment(\.modelContext) private var context
    
    init(ingredients: [Ingredient] = []) {
        self.ingredients = ingredients
    }
    
    var filteredIngredients: [Ingredient] {
        if searchedText.isEmpty {
            return ingredients
        }
        return ingredients.filter { ingredient in
            ingredient.name.localizedCaseInsensitiveContains(searchedText)
        }
    }
    
    private func delete(indexSet: IndexSet) {
        print("PS:: Trying to delete...")
        indexSet.forEach { index in
            let ingredient = filteredIngredients[index]
            print("PS:: Deleteing \(ingredient) from context")
            context.delete(ingredient)
            do {
                try context.save()
            } catch {
                // Swallow
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                // This should not check on filteredIngredients else it will hide the search bar
                // if no match found
                if ingredients.isEmpty {
                    ContentNotFoundView(
                        labelText: "No Ingredient Found",
                        descriptionText: "Please add an ingredient to the list",
                        systemImageName: "carrot.fill")
                } else {
                    SearchView(searchedText: $searchedText)
                }
                List {
                    ForEach(filteredIngredients) { ingredient in
                        NavigationLink {
                            AddIngredientView(name: ingredient.name)
                        } label: {
                            Text(ingredient.name)
                        }
                    }
                    .onDelete(perform: delete)
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

//#Preview {
//    IngredientsScreen()
//        .modelContainer(for: [Ingredient.self])
//}
