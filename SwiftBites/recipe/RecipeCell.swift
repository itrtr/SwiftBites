import SwiftUI

struct RecipeCell: View {
    var recipe: Recipe
    @State private var currentIndex: Int = 0 // To track the current image in the carousel
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect() // Auto-scroll timer

    var body: some View {
        VStack(alignment: .leading) {
            if !recipe.imageData.isEmpty {
                ZStack {
                    TabView(selection: $currentIndex) {
                        ForEach(recipe.imageData.indices, id: \.self) { index in
                            if let uiImage = UIImage(data: recipe.imageData[index]) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .tag(index)
                            } else {
                                // Fallback for invalid image data
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.gray)
                                    .tag(index)
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .frame(minWidth: 300)
                    .frame(height: 130) // Adjust height based on your design
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onReceive(timer) { _ in
                        // Automatically move to the next image
                        withAnimation {
                            currentIndex = (currentIndex + 1) % recipe.imageData.count
                        }
                    }
                }
            }

            // Title and detail below the carousel
            Text(recipe.title)
                .font(.headline)
                .padding(.top, 5)
            Text(recipe.detail)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        //.border(Color.gray, width: 1)
        .padding(.vertical, 0)
    }
}