//
//  VKApiWorker.swift
//  PP
//
//  Created by Алексей on 03.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation
import SwiftyVK

final class VKApiWorker {
   
    class func usersGet() {
        _ = VK.API.Users.get([
            .fields: "photo_200,relation"
            ]).send(onSuccess: { response in
                User.firstName = response[0, "first_name"].stringValue
                User.lastName = response[0, "last_name"].stringValue
                User.relation = response[0, "relation"].stringValue
                User.linkProfileImage = response[0, "photo_200"].stringValue
            }, onError: { error in
                print(error)
            })
    }
    
    class func getSubscriptions() {
        VK.API.Users.getSubscriptions([
            .count: "50",
            VK.Arg.extended: "1"
            ]).send(onSuccess: { response in
                User.subscriptions = response["items"].arrayValue.map({$0["name"].stringValue})
            NotificationCenter.default.post(.init(name: Notification.Name(rawValue: "vkDidAutrorize")))
        }, onError: { error in
            print(error)
        })
    }
   

}
