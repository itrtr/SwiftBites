//
//  CategorySection.swift -> Handling the view of each category
//  SwiftBites
//
//  Created by Singh, Pankaj on 22/11/24.
//

import SwiftUI
import SwiftData

struct CategorySection: View {
    var recipes: [Recipe]
    var category: Category
    @State var shouldOpenCategoryForm: Bool = false
    @State var categoryFormMode: CategoryFormMode = .add

    var body: some View {
        VStack(alignment: .leading, spacing: 4) { // Reduce vertical spacing further
            HStack {
                Text(category.name).font(.title).fontDesign(.serif)
                Spacer()
                Button {
                    shouldOpenCategoryForm = true
                    categoryFormMode = .edit(category)
                } label: {
                    Text("Edit").foregroundStyle(.blue)
                }
                
            }//.border(.gray, width: 1)
            
            if category.recipes.isEmpty {
                ContentNotFoundView(
                    labelText: "No Recipe Found",
                    descriptionText: "Please add a recipe for this category to see here",
                    systemImageName: "fork.knife.circle.fill"
                )
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 30) { // Tighten spacing between RecipeCell views
                        ForEach(recipes) { recipe in
                            VStack(alignment: .leading) {
                                RecipeCell(recipe: recipe)
                                //                                .frame(maxWidth: 300) // Set consistent size
                                    .onTapGesture {
                                        // RecipeForm() action
                                    }
                                TagView(categoryName: category.name, servingSize: recipe.servingCount, servingTime: recipe.servingTime)
                            }
                        }
                    }
                }//.border(.red, width: 1)
            }
        }
        .padding(.horizontal, 2) // Reduce outer padding further
        .padding(.vertical, 4) // Tighten vertical padding
        .navigationDestination(isPresented: $shouldOpenCategoryForm) {
            CategoryForm(mode: categoryFormMode)
        }
//        .border(Color.gray, width: 1) // Reduce border width slightly
    }
}



//#Preview {
//    CategorySection(category: Category(name: "Category"))
//        .modelContainer(for: [Category.self, Recipe.self])
//}
