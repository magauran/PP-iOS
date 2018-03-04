//
//  Ingredient.swift
//  PP
//
//  Created by Алексей on 04.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation

final class Ingredient {
    
    var value: String!
    var name: String!
    
    init(value: String, name: String) {
        self.value = value
        self.name = name
    }
    
}


extension Ingredient: Decodable {
    enum CodingKeys: String, CodingKey {
        case value
        case name
    }
    
    public convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Ingredient.CodingKeys.self)
        
        let value = try values.decode(String.self, forKey: .value)
        let name = try values.decode(String.self, forKey: .name)
       
        self.init(value: value, name: name)
    }
}
