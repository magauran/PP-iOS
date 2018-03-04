//
//  PPApiWorker.swift
//  PP
//
//  Created by Алексей on 04.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PPApiWorker {
    
    static let baseUrl = "http://159.65.117.182:9999/"
    
    
    class func getRecomendedRecipes(body: JSON, completion: @escaping ([Recipe]) -> Void) {
      
        let headers = [
            "Content-Type":"application/json",
            ]
        
        // JSON Body
        let body = body.dictionaryObject!
        
        let url = URL.init(string: baseUrl + "recommend")!
        
        var recipes = [Recipe]()
        
        // Fetch Request
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    let jsonData = response.data
                    let jsonDecoder = JSONDecoder()
                    
                    let json = JSON(jsonData!)
                    let array = json["result"].arrayValue
                    for i in array {
                        var ingredients: [Ingredient]!
                        if let ingr = try? jsonDecoder.decode([Ingredient].self, from: try! i["ingredients"].rawData()) {
                            ingredients = ingr
                        }
                        
                        let title = i["title"].stringValue
                        let category = i["category"].intValue
                        let time = i["time"].stringValue
                        let photo = i["photo"].stringValue
                        let instructions = i["instructions"].arrayObject as! [String]
                        let r = Recipe.init(ingredients: ingredients, photo: photo, title: title, time: time, category: category, instructions: instructions)
                        recipes.append(r)
                    }
                    
                    if let predictions = try? jsonDecoder.decode([Double].self, from: try! json["predictions"].rawData()) {
                        User.predictions = predictions
                    }
                    
                }
                else {
                    
                    debugPrint("HTTP Request failed: \(String(describing: response.result.error))")
                }
                completion(recipes)
        }
        
    }
    
    class func getRecipesByCategory(category: Int, completion: @escaping ([Recipe]) -> Void) {
        
        let url = URL.init(string: baseUrl + "page_\(category)")!
        let headers = [
            "Content-Type":"application/json",
            ]
        var recipes = [Recipe]()
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let isBreakfast = (hour > 3 && hour < 13) ? 1 : 0
        let body = ["isBreakfast" : isBreakfast]
        
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                                if (response.result.error == nil) {
                                    let jsonData = response.data
                                    let jsonDecoder = JSONDecoder()
                                    
                                    
                                    let json = JSON(jsonData!)
                                    let array = json["result"].arrayValue
                                    for i in array {
                                        var ingred: [Ingredient]!
                                        if let ingr = try? jsonDecoder.decode([Ingredient].self, from: try! i["ingredients"].rawData()) {
                                            ingred = ingr
                                        }
                                        let title = i["title"].stringValue
                                        let category = i["category"].intValue
                                        let time = i["time"].stringValue
                                        let photo = i["photo"].stringValue
                                        let instructions = i["instructions"].arrayObject as! [String]
                                        let r = Recipe.init(ingredients: ingred, photo: photo, title: title, time: time, category: category, instructions: instructions)
                                        recipes.append(r)
                                    }
                                }
                                else {

                                    debugPrint("HTTP Request failed: \(String(describing: response.result.error))")
                                }
                completion(recipes)
        }
        
    }
    
    
}


