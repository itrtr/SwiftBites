//
//  IngredientForm.swift -> View responsible for adding an ingredient
//  SwiftBites
//
//  Created by Singh, Pankaj on 22/11/24.
//

import SwiftUI

struct IngredientForm: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var mode: IngredientFormMode
    @State private var name: String = ""
    
    var isValid: Bool {
        !name.isEmpty
    }
    
    var body: some View {
        NavigationStack() {
            Form {
                Section {
                    TextField("Name", text: $name)
                        .autocorrectionDisabled()
                }
            }
            .navigationTitle(getNavigationBarTitle())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: saveIngredient) {
                        Text("Save")
                    }.disabled(!isValid)
                }
            }
            .onAppear() {
                if case let .edit(category) = mode {
                    name = category.name
                }
            }
            
            if case .edit = mode {
                Section {
                    Button(action: deleteIngredient) {
                        Label("Delete Ingredient", systemImage: "trash")
                            .foregroundStyle(.red)
                    }
                }
            }
            
        }
    }
    
    private func deleteIngredient() {
        guard isValid else { return }
        
        if case let .edit(ingredient) = mode {
            modelContext.delete(ingredient)
        }
        print("Saving ingredient...")
        do {
            try modelContext.save()
        } catch {
            print("Error deleting ingredient: \(error)")
        }
        
        dismiss()
    }
    
    private func saveIngredient() {
        guard isValid else { return }
        
        if case let .edit(ingredient) = mode {
            ingredient.name = name
        } else {
            let ingredient = Ingredient(name: name)
            modelContext.insert(ingredient)
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving ingredient: \(error)")
        }
        
        dismiss()
    }
    
    private func getNavigationBarTitle() -> String {
        switch mode {
        case .add:
            return "Add Ingredient"
        case .edit(let ingredient):
            return "Edit " + ingredient.name
        }
    }
}

#Preview {
    IngredientForm(mode: .add)
        .modelContainer(for: [Ingredient.self])
}
