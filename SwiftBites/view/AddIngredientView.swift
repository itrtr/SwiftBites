import SwiftUI

struct AddIngredientView: View {
    private var previousName: String
    @State var name: String
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var isValid: Bool {
        !name.isEmpty
    }
    
    init(name: String = "") {
        self.name = name
        self.previousName = name
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
                        if name == previousName { dismiss() } // Do not do anything if there is no ingredient change
                        context.delete(Ingredient(name: previousName))
                        context.insert(Ingredient(name: name))
                        do {
                            try context.save()
                        } catch {
                            // Swallow
                        }
                        dismiss()
                    }) {
                        Text("Save")
                    }
                }

            }
        }
    }
}


//
//#Preview {
////    AddIngredientView(item: .constant(Ingredient(name: "Apple")))
//    AddIngredientView()
//        .modelContainer(for: [Ingredient.self])
//}
