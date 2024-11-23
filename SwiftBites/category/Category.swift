//
//  Category.swift - Represents the category for SwiftBite
//  SwiftBites
//
//  Created by Singh, Pankaj on 21/11/24.
//

import Foundation
import SwiftData

@Model
final class Category: Identifiable {
    var id: UUID
    @Attribute(.unique) var name: String
    
    var recipes: [Recipe]
    
    init(id: UUID = .init(), name: String, recipes: [Recipe] = []) {
        self.id = id
        self.name = name
        self.recipes = recipes
    }
}
