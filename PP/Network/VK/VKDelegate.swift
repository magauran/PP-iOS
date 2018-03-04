//
//  VKDelegate.swift
//  PP
//
//  Created by Алексей on 03.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation
import SwiftyVK

class VkDelegate: VKDelegate {
    
    let appId = "6394857"
    
    init() {
        VK.configure(withAppId: appId, delegate: self)
    }
    
    func vkWillAuthorize() -> Set<VK.Scope> {
        let scope: Set<VK.Scope> = [.offline]
        return scope
    }
    
    func vkDidUnauthorize() {
    }
    
    func vkAutorizationFailedWith(error: AuthError) {
        print(error)
    }
    
    func vkShouldUseTokenPath() -> String? {
        return nil
    }
    
    func vkWillPresentView() -> UIViewController {
        return UIApplication.shared.delegate!.window!!.rootViewController!
    }
    
    func vkDidAuthorizeWith(parameters: Dictionary<String, String>) {
        VKApiWorker.usersGet()
        VKApiWorker.getSubscriptions()
    }
    
}
