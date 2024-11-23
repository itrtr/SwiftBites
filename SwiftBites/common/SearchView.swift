import SwiftUI

struct SearchView: View {
    @Binding var searchedText: String
    var placeholder: String = "Search..."
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField(placeholder, text: $searchedText)
                .textFieldStyle(.plain)
                .autocorrectionDisabled()
            
            if !searchedText.isEmpty {
                Button(action: {
                    searchedText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemGray6))
        }
        .padding()
    }
}
