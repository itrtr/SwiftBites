import SwiftUI

struct RecipeSortModalView: View {
    @Binding var selectedSortOption: RecipeSortOption
    
    var body: some View {
        ForEach([RecipeSortOption.name, .servingAscending, .servingDescending, .timeAscending, .timeDescending], id: \.self) { option in
            Button(action: {
                selectedSortOption = option
                sortItems(by: option)
            }) {
                Label {
                    Text(option.title)
                } icon: {
                    if selectedSortOption == option {
                        Image(systemName: "checkmark")
                    }
                }
            }
        }
    }
    
    private func sortItems(by option: RecipeSortOption) {
        switch option {
        case .name:
            print("Sorting by name")
        case .servingAscending:
            print("Sorting by serving - Ascending")
        case .servingDescending:
            print("Sorting by serving - Descending")
        case .timeAscending:
            print("Sorting by time - Ascending")
        case .timeDescending:
            print("Sorting by time - Descending")
        }
    }
}

#Preview {
    let recipes = [
        Recipe(title: "Classic Margherita Pizza", detail: "A simple yet delicious pizza with tomato, mozzarella, basil, and olive oil."),
        Recipe(title: "Spaghetti Carbonara", detail: "A classic Italian pasta dish made with eggs, cheese, pacetta, and pepper.")
    ]
    RecipeSortModalView(selectedSortOption: .constant(.name))
}
