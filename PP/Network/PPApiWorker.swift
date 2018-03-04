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
    
    
    class func getRecomendedRecipies(body: JSON) {
      
        let headers = [
            "Content-Type":"application/json",
            ]
        
        // JSON Body
        let body = body.dictionaryObject!
        
        let url = URL.init(string: baseUrl + "recommend")!
        
        // Fetch Request
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
            //.validate(statusCode: 200..<300)
            .response { response in
                print(response)
//                if (response.result.error == nil) {
//                    debugPrint("HTTP Response Body: \(response.data)")
//                }
//                else {
//                    debugPrint("HTTP Request failed: \(response.result.error)")
//                }
        }
    }
    
    
    class func getRecipiesByCategory(category: Int) {
        
        let url = URL.init(string: baseUrl + "page_\(category)")!
        
        // Fetch Request
        Alamofire.request(url)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                                if (response.result.error == nil) {
                                    debugPrint("HTTP Response Body: \(response.data)")
                                }
                                else {

                                    debugPrint("HTTP Request failed: \(response.result.error)")
                                }
        }
    }
    
    
}


