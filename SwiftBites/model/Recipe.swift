import Foundation
import SwiftUI
import SwiftData

@Model
final class Recipe {
    var title: String
    var detail: String
    var servingCount: Int
    var servingTime: Int
    
    @Relationship(deleteRule: .noAction, inverse: \Tag.recipes) var tags: [Tag]
    @Relationship(deleteRule: .noAction) var ingredients: [Ingredient]
    @Relationship(deleteRule: .noAction, inverse: \Category.recipes) var category: Category?
    
    @Relationship(deleteRule: .cascade) var imageData: [Data] // Only delete the images when this recipe is deleted
    
    init(title: String,
         detail: String,
         servingCount: Int = 0,
         servingTime: Int = 0,
         tags: [Tag] = [],
         imageData: [Data] = [],
         category: Category? = nil,
         ingredients: [Ingredient] = []) {
        
        self.title = title
        self.detail = detail
        self.servingCount = servingCount
        self.servingTime = servingTime
        self.tags = tags
        self.imageData = imageData
        self.category = category
        self.ingredients = []
    }
}
