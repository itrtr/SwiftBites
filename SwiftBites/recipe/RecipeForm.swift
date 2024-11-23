//
//  RecipeForm.swift
//  SwiftBites
//
//  Created by Singh, Pankaj on 22/11/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct RecipeForm: View {
    var mode: RecipeFormMode
    
    @State private var images: [Image] = []
    @State private var recipeName: String = ""
    @State private var instructions: String = ""
    @State private var summary: String = ""
    @State private var ingredientMappings: [IngredientMapping] = []
    @State private var selectedCategory: Category = Constants.NONE_CATEGORY
    @State private var servingSize: Int = 1
    @State private var servingTime: Int = 5
    @State private var ingredientDetail: String = ""
    
    @State private var shouldLoadIngredientSheet: Bool = false
    
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Query var categories: [Category]
    
    private func getRecipeNamePlaceholder() -> String {
        switch mode {
        case .add:
            Constants.DEFAULT_RECIPE_TITLE
        case .edit(let recipe):
            "Edit " + recipe.title
        }
    }
    
    private func getRecipeSummaryPlaceholder() -> String {
        switch mode {
        case .add:
            Constants.DEFAULT_RECIPE_SUMMARY
        case .edit(let recipe):
            recipe.detail
        }
    }
    
    private func loadInitialData() {
        if case let .edit(recipe) = mode {
            recipeName = recipe.title
            summary = recipe.detail
            for image in recipe.imageData {
                images.append(Image(uiImage: UIImage(data: image)!))
            }
            servingSize = recipe.servingCount
            servingTime = recipe.servingTime
            ingredientMappings = recipe.ingredientMappings
            instructions = recipe.instructions
            selectedCategory = recipe.category ?? Constants.NONE_CATEGORY
        }
    }
    
    private func getImageData(images: [Image]) -> [Data] {
        var imageData: [Data] = []
        for image in images {
            guard let data = image.saveAsData() else { continue }
            imageData.append(data)
        }
        return imageData
    }
    
    private func saveRecipe() {
        if case let .edit(recipe) = mode {
            selectedCategory.recipes.removeAll(where: { $0.title == recipe.title })
            recipe.title = recipeName
            recipe.detail = summary
            recipe.servingCount = servingSize
            recipe.servingTime = servingTime
            recipe.imageData = getImageData(images: images)
            recipe.category = selectedCategory
            recipe.ingredientMappings = ingredientMappings
            recipe.instructions = instructions
            selectedCategory.recipes.append(recipe)
        } else {
            let newRecipe = Recipe(title: recipeName,
                                   detail: summary,
                                   servingCount: servingSize,
                                   servingTime: servingTime,
                                   imageData: getImageData(images: images),
                                   category: selectedCategory,
                                   ingredientMappings: ingredientMappings,
                                   instructions: instructions)
            selectedCategory.recipes.append(newRecipe)
            modelContext.insert(newRecipe)
        }
        
        
        do {
            try modelContext.save()
        } catch {
            // Swallow
        }
        
        dismiss()
    }
    
    private func deleteRecipe(recipe: Recipe) {
        modelContext.delete(recipe)
        do {
            try modelContext.save()
        } catch {
            // Swallow
        }
        dismiss()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // Section for recipe images
                Section() {
                    ImageSelectionView(images: $images)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .listRowInsets(EdgeInsets())
                .frame(height: images.isEmpty ? Constants.emptyImageSetHeight : Constants.imageSetHeight)
                
                // Section for recipe name
                Section {
                    TextField(getRecipeNamePlaceholder(), text: $recipeName)
                        .font(.subheadline)
                        .autocorrectionDisabled()
                        .padding(.leading, 5)
                } header: {
                    Text("NAME").font(.headline).padding(.bottom, 5)
                }.listRowInsets(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 15))
                
                // Section for recipe summary
                Section {
                    ZStack(alignment: .topLeading) {
                        if summary.isEmpty {
                            Text(Constants.DEFAULT_RECIPE_SUMMARY)
                                .font(.subheadline)
                                .autocorrectionDisabled()
                                .foregroundColor(.secondary.opacity(0.5))
                                .padding(.top, 10)
                                .padding(.leading, 8)
                        }
                        
                        TextEditor(text: $summary)
                            .font(.subheadline)
                            .disableAutocorrection(true)
                            .background(Color.clear)
                            .frame(minHeight: 100)
                    }
                } header: {
                    Text("SUMMARY").font(.headline).padding(.bottom, 5)
                }.listRowInsets(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 15))
                
                // Section for category of recipe (Add an additional NONE category)
                Section {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach([Constants.NONE_CATEGORY] + categories, id: \.self) { category in
                            Text(category.name).tag(category as Category)
                        }
                    }.padding(.leading, 5)
                }.listRowInsets(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 15))
                
                // Section for serving count and serving time
                Section {
                    // Serving and Time
                    IncrementDecrementCounterView(counterResult: $servingSize,
                            counterText: "Servings: \(servingSize) person",
                            counterFrequency: Constants.DEFAULT_SERVING_SIZE_DIFF)
                    
                    IncrementDecrementCounterView(counterResult: $servingTime,
                            counterText: "Servings: \(servingTime) minutes",
                            counterFrequency: Constants.DEFAULT_SERVING_TIME_DIFF)
                    
                    
                }.listRowInsets(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 15))
                
                // Section for ingredients of this recipe
                Section {
                    //IngredientsShortView(ingredients: ingredients)
                    if (ingredientMappings.isEmpty) {
                        ContentNotFoundView(labelText: "No Ingredients", descriptionText: "Please add an ingredient to see here", systemImageName: "carrot")
                    }
                    List {
                        ForEach(ingredientMappings) { ingredientMapping in
                            HStack {
                                Text(ingredientMapping.ingredient.name)
                                TextField("Quantity", text: Binding(
                                    get: { ingredientMapping.quantity },
                                    set: { newValue in
                                        if let index = ingredientMappings.firstIndex(where: { $0.id == ingredientMapping.id }) {
                                            ingredientMappings[index].quantity = newValue
                                        }
                                    }
                                ))
                            }
                        }
                    }
                    Button {
                        shouldLoadIngredientSheet = true
                    } label: {
                        HStack {
                            Image(systemName: "carrot").foregroundStyle(.primary)
                            Text("Add Ingredient").foregroundStyle(.primary)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } header: {
                    Text("INGREDIENTS").font(.headline).padding(.bottom, 5)
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 15))
                
                
                // Section for instructions of the recipe
                Section {
                    ZStack(alignment: .topLeading) {
                        if instructions.isEmpty {
                            Text(Constants.DEFAULT_RECIPE_INSTRUCTIONS)
                                .font(.subheadline)
                                .autocorrectionDisabled()
                                .foregroundColor(.secondary.opacity(0.5))
                                .padding(.top, 10)
                                .padding(.leading, 8)
                        }
                        
                        TextEditor(text: $instructions)
                            .font(.subheadline)
                            .disableAutocorrection(true)
                            .background(Color.clear)
                            .frame(minHeight: 120)
                    }
                } header: {
                    Text("INSTRUCTIONS").font(.headline).padding(.bottom, 5)
                        .foregroundColor(.secondary)
                }.listRowInsets(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 15))
                
                // Optional delete button
                if case .edit(let recipe) = mode {
                    Section {
                        Button {
                            deleteRecipe(recipe: recipe)
                        } label: {
                            HStack {
                                Image(systemName: "trash").foregroundStyle(.red)
                                Text("Delete recipe").foregroundStyle(.red)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
            .onAppear { loadInitialData() }
            .navigationTitle("Add Recipe")
            .sheet(isPresented: $shouldLoadIngredientSheet) {
                NavigationStack {
                    IngredientsView(onItemSelected: { selectedIngredient in
                        print("Adding ingredient: \(selectedIngredient.name) in list")
                        ingredientMappings.append(IngredientMapping(ingredient: selectedIngredient, quantity: ""))
                    })
                }
                .presentationDetents([.medium])
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        saveRecipe()
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
}

#Preview {
    RecipeForm(mode: .add)
        .modelContainer(for: [Recipe.self, Category.self])
}
