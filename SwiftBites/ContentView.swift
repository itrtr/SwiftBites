import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedScreen: ScreenEnum = .RecipesScreen
    @Query var ingredients: [Ingredient]
    @Query var recipes: [Recipe]
    
    var body: some View {
        TabView(selection: $selectedScreen) {
            RecipesScreen(recipes: recipes)
                .tabItem {
                    Label("Recipes", systemImage: "fork.knife.circle.fill")
                }
                .tag(ScreenEnum.RecipesScreen)
            
            CategoriesScreen()
                .tabItem {
                    Label("Categories", systemImage: "bookmark.circle")
                }
                .tag(ScreenEnum.CategoriesScreen)
            
            IngredientsScreen(ingredients: ingredients)
                .tabItem {
                    Label("Ingredients", systemImage: "carrot.fill")
                }
                .tag(ScreenEnum.IngredientsScreen)
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = .systemBackground
            
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            UITabBar.appearance().standardAppearance = tabBarAppearance
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Ingredient.self, Recipe.self, Tag.self, Category.self])
}
