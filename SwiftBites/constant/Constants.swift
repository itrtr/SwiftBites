//
//  IngredientList.swift
//  SwiftBites
//
//  Created by Singh, Pankaj on 18/11/24.
//

import Foundation

struct Constants {
    
    static let NONE_CATEGORY: Category = .init(name: "None")
    
    // Recipe related constants
    static let DEFAULT_RECIPE_TITLE: String = "Margherita Pizza"
    static let DEFAULT_RECIPE_SUMMARY: String = "Declicious blend of fresh basil, mozzarella, and tomato on crispy crust."
    static let DEFAULT_RECIPE_INSTRUCTIONS: String = """
    Step 1: Take all the ingredients for the recipe
    Step 2: Wash them properly to clean them
    """
    static let DEFAULT_SERVING_SIZE_DIFF: Int = 1
    static let DEFAULT_SERVING_TIME_DIFF: Int = 5
    
    
    static let emptyImageSetHeight: CGFloat = 10
    static let imageSetHeight: CGFloat = 150
    
    struct IngredientConstants {
        static let initialIngredientList: [Ingredient] = [
            Ingredient(name: "Salt"),
            Ingredient(name: "Sugar"),
            Ingredient(name: "Black Pepper"),
            Ingredient(name: "Garlic"),
            Ingredient(name: "Onion"),
            Ingredient(name: "Tomato"),
            Ingredient(name: "Potato"),
            Ingredient(name: "Chicken"),
            Ingredient(name: "Beef"),
            Ingredient(name: "Pork"),
            Ingredient(name: "Carrot"),
            Ingredient(name: "Celery"),
            Ingredient(name: "Broccoli"),
            Ingredient(name: "Cucumber"),
            Ingredient(name: "Lettuce"),
            Ingredient(name: "Spinach"),
            Ingredient(name: "Mushroom"),
            Ingredient(name: "Bell Pepper"),
            Ingredient(name: "Zucchini"),
            Ingredient(name: "Eggplant"),
            Ingredient(name: "Cheese"),
            Ingredient(name: "Milk"),
            Ingredient(name: "Eggs"),
            Ingredient(name: "Butter"),
            Ingredient(name: "Olive Oil"),
            Ingredient(name: "Vegetable Oil"),
            Ingredient(name: "Flour"),
            Ingredient(name: "Rice"),
            Ingredient(name: "Pasta"),
            Ingredient(name: "Bread"),
            Ingredient(name: "Yeast"),
            Ingredient(name: "Baking Powder"),
            Ingredient(name: "Baking Soda"),
            Ingredient(name: "Vinegar"),
            Ingredient(name: "Soy Sauce"),
            Ingredient(name: "Fish Sauce"),
            Ingredient(name: "Honey"),
            Ingredient(name: "Lemon"),
            Ingredient(name: "Lime"),
            Ingredient(name: "Ginger"),
            Ingredient(name: "Cinnamon"),
            Ingredient(name: "Vanilla Extract"),
            Ingredient(name: "Parsley"),
            Ingredient(name: "Cilantro"),
            Ingredient(name: "Thyme"),
            Ingredient(name: "Rosemary"),
            Ingredient(name: "Basil"),
            Ingredient(name: "Oregano"),
            Ingredient(name: "Chili Powder"),
            Ingredient(name: "Curry Powder"),
            Ingredient(name: "Paprika")
        ]

    }
}
