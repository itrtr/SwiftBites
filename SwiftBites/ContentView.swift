import SwiftUI

struct ContentView: View {
    @State private var selectedScreen: ScreenEnum = .RecipesScreen
    
    var body: some View {
        TabView(selection: $selectedScreen) {
            RecipesScreen(recipes: [])
                .tabItem {
                    Label("Recipes", systemImage: "fork.knife.circle.fill")
                }
                .tag(ScreenEnum.RecipesScreen)
            
            CategoriesScreen()
                .tabItem {
                    Label("Categories", systemImage: "bookmark.circle")
                }
                .tag(ScreenEnum.CategoriesScreen)
            
            IngredientsScreen()
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
}
