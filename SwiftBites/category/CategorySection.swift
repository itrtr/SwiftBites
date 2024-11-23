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
    @State var shouldOpenRecipeForm: Bool = false
    @State var categoryFormMode: CategoryFormMode = .add
    @State var recipeFormMode: RecipeFormMode = .add
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text(category.name).font(.title).fontDesign(.serif)
                    Spacer()
                    Button {
                        shouldOpenCategoryForm = true
                        categoryFormMode = .edit(category)
                    } label: {
                        Text("Edit").foregroundStyle(.blue)
                    }
                    
                }
                if category.recipes.isEmpty {
                    ContentNotFoundView(
                        labelText: "No Recipe Found",
                        descriptionText: "Please add a recipe for this category to see here",
                        systemImageName: "fork.knife.circle.fill"
                    )
                    Button {
                        shouldOpenRecipeForm = true
                        recipeFormMode = .add
                    } label: {
                        Text("Add Recipe")
                    }.buttonStyle(.borderedProminent)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30) {
                            ForEach(recipes) { recipe in
                                VStack(alignment: .leading) {
                                    RecipeCell(recipe: recipe).frame(maxWidth: 300).onTapGesture {
                                        shouldOpenRecipeForm = true
                                        recipeFormMode = .edit(recipe)
                                    }
                                    TagView(categoryName: category.name, servingSize: recipe.servingCount, servingTime: recipe.servingTime)
                                }
                            }
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $shouldOpenCategoryForm) {
                CategoryForm(mode: categoryFormMode)
            }
            .navigationDestination(isPresented: $shouldOpenRecipeForm) {
                RecipeForm(mode: recipeFormMode)
            }
        }
    }
}
