//
//  CategoryForm.swift - This view will be used to add/edit category and save the category
//  SwiftBites
//
//  Created by Singh, Pankaj on 22/11/24.
//

import SwiftUI

struct CategoryForm: View {
    var mode: CategoryFormMode
    
    @State private var name: String = ""
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
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
                    Button(action: saveCategory) {
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
                    Button(action: deleteCategory) {
                        Label("Delete Category", systemImage: "trash")
                            .foregroundStyle(.red)
                    }
                }
            }
            
        }
    }
    
    private func getNavigationBarTitle() -> String {
        switch mode {
        case .add:
            "Add Category"
        case .edit(let category):
            "Edit " + category.name
        }
    }
    
    private func saveCategory() {
        guard isValid else { return }
        
        if case let .edit(category) = mode {
            category.name = name
        } else {
            let category = Category(name: name)
            modelContext.insert(category)
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving category: \(error)")
        }
        
        dismiss()
    }
    
    private func deleteCategory() {
        guard isValid else { return }
        
        if case let .edit(category) = mode {
            modelContext.delete(category)
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Error deleting category: \(error)")
        }
        
        dismiss()
    }
}

#Preview {
    CategoryForm(mode: .add)
        .modelContainer(for: [Category.self])
}
