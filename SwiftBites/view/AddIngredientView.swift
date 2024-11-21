import SwiftUI

struct AddIngredientView: View {
    @Environment(\.dismiss) private var dismiss
    @State var name: String
    
    var isValid: Bool {
        !name.isEmpty
    }
    
    init(name: String = "") {
        self.name = name
    }
    
    var body: some View {
        VStack() {
            HStack {
                Spacer()
                TextField("Ingredient:", text: $name)
                    .textFieldStyle(.plain)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.teal)
                    )
                Spacer()
            }
            Spacer()
        }
        .toolbar {
            if isValid {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // Update the ingredient
                        dismiss()
                    }) {
                        Text("Save")
                    }
                }

            }
        }
    }
}

#Preview {
//    AddIngredientView(item: .constant(Ingredient(name: "Apple")))
    AddIngredientView()
}
