import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedScreen: ScreenEnum = .RecipesScreen
    
    var body: some View {
        TabView(selection: $selectedScreen) {
            
            RecipesView()
                .tabItem {
                    Label("All Recipes", systemImage: "book.circle.fill")
                }
                .tag(ScreenEnum.RecipesScreen)
            
            CategoriesView()
                .tabItem {
                    Label("Categories", systemImage: "bookmark.circle")
                }
                .tag(ScreenEnum.CategoriesScreen)
            
            IngredientsView()
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
        .modelContainer(for: [Ingredient.self, Recipe.self, Category.self])
}
