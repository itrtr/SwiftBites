import SwiftUI

struct RecipeSortModalView: View {
    @Binding var selectedSortOption: RecipeSortOption
    
    var body: some View {
        ForEach([RecipeSortOption.name, .servingAscending, .servingDescending, .timeAscending, .timeDescending], id: \.self) { option in
            Button(action: {
                selectedSortOption = option
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
}
