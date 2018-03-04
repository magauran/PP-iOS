//
//  Recipe.swift
//  PP
//
//  Created by Алексей on 04.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation
import SwiftyJSON

final class Recipe {
    
    var ingredients: [Ingredient]!
    var photo: String!
    var title: String!
    var time: String!
    var category: Int!
    var instructions: [String]!
    
    init(ingredients: Array<Ingredient>, photo: String = "", title: String, time: String, category: Int
         , instructions: Array<String>) {
        self.ingredients = ingredients
        self.photo = photo
        self.title = title
        self.time = time
        self.category = category
        self.instructions = instructions
    }
    
}

extension Recipe: Decodable {
    enum CodingKeys: String, CodingKey {
        case ingredients
        case photo
        case title
        case time
        case category
        case instructions
    }
    
    public convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Recipe.CodingKeys.self)
        
        let ingredients = try values.decode(Array<Ingredient>.self, forKey: .ingredients)
        let photo = try values.decode(String.self, forKey: .photo)
        let title = try values.decode(String.self, forKey: .title)
        let time = try values.decode(String.self, forKey: .time)
        let category = try values.decode(Int.self, forKey: .category)
        let instructions = try values.decode(Array<String>.self, forKey: .instructions)
        
        self.init(ingredients: ingredients, photo: photo, title: title, time: time, category: category, instructions: instructions)
    }
    
}
