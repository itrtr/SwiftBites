//
//  Ingredient.swift
//  SwiftBites
//
//  Created by Singh, Pankaj on 17/11/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
final class Ingredient {
    var name: String
    init(name: String) {
        self.name = name
    }
}
