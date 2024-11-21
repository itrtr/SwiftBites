//
//  Category.swift
//  SwiftBites
//
//  Created by Singh, Pankaj on 21/11/24.
//

import Foundation
import SwiftData

@Model
final class Category {
    var name: String
    
    var recipes: [Recipe]
    
    init(name: String, recipes: [Recipe] = []) {
        self.name = name
        self.recipes = recipes
    }
}
