import Foundation
import SwiftUI
import SwiftData

@Model
final class Recipe {
    var title: String
    var detail: String
    var instructions: String
    var servingCount: Int
    var servingTime: Int
    
    //@Relationship(deleteRule: .noAction, inverse: \Tag.recipes) var tags: [Tag]
    @Relationship(deleteRule: .nullify, inverse: \Ingredient.recipes) var ingredients: [Ingredient]
    @Relationship(deleteRule: .nullify, inverse: \Category.recipes) var category: Category?
    
    @Relationship(deleteRule: .cascade) var imageData: [Data] // Only delete the images when this recipe is deleted
    
    init(title: String,
         detail: String,
         servingCount: Int = 0,
         servingTime: Int = 0,
         imageData: [Data] = [],
         category: Category? = nil,
         ingredients: [Ingredient] = [],
         instructions: String = "") {
        
        self.title = title
        self.detail = detail
        self.servingCount = servingCount
        self.servingTime = servingTime
        self.imageData = imageData
        self.category = category
        self.ingredients = ingredients
        self.instructions = instructions
    }
}
