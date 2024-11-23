//
//  SwiftBitesApp.swift
//  SwiftBites
//
//  Created by Singh, Pankaj on 17/11/24.
//

import SwiftUI

@main
struct SwiftBitesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Ingredient.self, Recipe.self, Category.self])
        }
    }
}
