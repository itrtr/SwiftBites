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
        VStack(alignment: .center, spacing: 20) {
            Spacer()
                .frame(height: 10)
            
            HStack {
                Spacer()
                    .frame(width: 15)
                
                TextField("name", text: $name)
                    .textFieldStyle(.plain)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black)
                    )
                
                Spacer()
                    .frame(width: 15)
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
