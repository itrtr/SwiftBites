//
//  CategoriesView.swift -> This view is resposible for viewing the entire categories
//  SwiftBites
//
//  Created by Singh, Pankaj on 22/11/24.
//

import SwiftUI
import SwiftData

struct CategoriesView: View {
    @State private var searchText: String = ""
    @Environment(\.modelContext) private var modelContext
    @Query var categories: [Category]
    
    // TODO:: Add use of #Predicate
    // Implement a search bar using a #Predicate to search categories by name.
    private var filteredCategories: [Category] {
        if searchText.isEmpty {
            return categories
        }
        return categories.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationStack {
            // We should show the search bar always unless the main category is empty
            if !categories.isEmpty {
                SearchView(searchedText: $searchText, placeholder: "Search Categories...")
            }
            
            if filteredCategories.isEmpty {
                ContentNotFoundView(labelText: "No Categories Found",
                                    descriptionText: "Please add a category to see here",
                                    systemImageName: "bookmark.circle")
                
                NavigationLink(destination: CategoryForm(mode: .add)) {
                    VStack {
                        Image(systemName: "plus.circle.fill").font(.title)
                        Text("Add a category")
                    }
                }
            } else {
                VStack {
                    ForEach(filteredCategories) { category in
                        NavigationLink(destination: CategoryForm(mode: .edit(category))) {
                            Text(category.name)
                        }
                    }
                }
                .navigationTitle("Categories")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(destination: CategoryForm(mode: .add)) {
                            Image(systemName: "plus.circle").font(.headline)
                        }
                    }
                }
                
                Spacer()
                Button(action: clearCategories) {
                    Text("Clear All Categories")
                }
            }
        }
    }
    
    private func clearCategories() {
        for category in categories {
            modelContext.delete(category)
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Error clearing notes: \(error)")
        }
    }
}

#Preview {
    CategoriesView()
        .modelContainer(for: [Category.self])
}