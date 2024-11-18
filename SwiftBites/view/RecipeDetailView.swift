import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(recipe.title)
                .font(.title)
                .bold()
            
            Text(recipe.detail)
                .font(.body)
            
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

/*
 #Preview {
 RecipeDetailView()
 }
 */
