//
//  Recipe.swift
//  SwiftBites
//
//  Created by Singh, Pankaj on 17/11/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
final class Recipe {
    var title: String
    var detail: String
    var servingCount: Int
    var servingTime: Int
    var photos: [String]
    
    @Relationship(deleteRule: .cascade, inverse: \Tag.recipes)
    var tags: [Tag]
    
    init(title: String, detail: String, servingCount: Int = 0, servingTime: Int = 0, tags: [Tag] = [], photos: [String] = []) {
        self.title = title
        self.detail = detail
        self.servingCount = servingCount
        self.servingTime = servingTime
        self.tags = tags
        self.photos = photos
    }
}
