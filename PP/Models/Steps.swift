//
//  Steps.swift
//  PP
//
//  Created by Алексей on 03.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Steps: Encodable {
    
    var count: Int
    var date: Date
    
    init(_ count: Int, _ date: Date) {
        self.count = count
        self.date = date
    }
    
}

extension Array where Element: Steps {
    func toJSON() -> JSON {
        
        let encodedData = try? JSONEncoder().encode(self)
        let json = JSON(encodedData!)
        return json
    }
}
