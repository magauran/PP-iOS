//
//  AppDelegate.swift
//  PP
//
//  Created by Алексей on 03.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit
import SwiftyVK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var vkDelegateReference : VKDelegate?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        vkDelegateReference = VkDelegate()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let app = options[.sourceApplication] as? String
        VK.process(url: url, sourceApplication: app)
        return true
    }
    
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        VK.process(url: url, sourceApplication: sourceApplication)
        return true
    }

}

