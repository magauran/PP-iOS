//
//  UIImage+NSURLConnection.swift
//  PP
//
//  Created by Алексей on 04.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        
        
        let url = URL(string: urlString)!
        Alamofire.request(url).responseData { (response) in
            if response.error == nil {
                print(response.result)
                if let data = response.data {
                   self.image = UIImage(data: data)
                } else {
                    self.image = UIImage(named: "fon1")!
                }
            }
       }
    }
}
