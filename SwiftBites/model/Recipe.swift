import Foundation
import SwiftUI
import SwiftData


@Model
final class IngredientMapping: Identifiable {
    var id = UUID()
    var ingredient: Ingredient
    var quantity: String
    
    init(ingredient: Ingredient, quantity: String) {
        self.ingredient = ingredient
        self.quantity = quantity
    }
}

@Model
final class Recipe {
    var title: String
    var detail: String
    var instructions: String
    var servingCount: Int
    var servingTime: Int
    @Relationship(deleteRule: .cascade) var ingredientMappings: [IngredientMapping]
    var category: Category?
    
    @Relationship(deleteRule: .cascade) var imageData: [Data]
    
    init(title: String,
         detail: String,
         servingCount: Int = 0,
         servingTime: Int = 0,
         imageData: [Data] = [],
         category: Category? = nil,
         ingredientMappings: [IngredientMapping] = [],
         instructions: String = "") {
        
        self.title = title
        self.detail = detail
        self.servingCount = servingCount
        self.servingTime = servingTime
        self.imageData = imageData
        self.category = category
        self.ingredientMappings = ingredientMappings
        self.instructions = instructions
    }
}
