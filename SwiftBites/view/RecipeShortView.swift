import SwiftUI

struct RecipeShortView: View {
    @State private var images: [Image] = []
    var recipe: Recipe
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ImageSelectionView(images: $images)
            Text(recipe.title)
                .font(.headline)
            Text(recipe.detail)
                .font(.subheadline)
                .foregroundColor(.gray)
            TagView(tags: recipe.tags).padding(.vertical, 5)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    RecipeShortView(recipe: Recipe(title: "Classic Margherita Pizza", detail: "A simple yet delicious pizza with tomato, mozzarella, basil, and olive oil.", servingCount: 4, servingTime: 120, tags: [
        Tag(image: "star", text: "Featured"),
        Tag(image: "tag", text: "Sale"),
        Tag(image: "flame", text: "Hot")
    ]))
}
