//
//  StartViewController.swift
//  PP
//
//  Created by Алексей on 03.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit
import SwiftyVK

class StartViewController: UIViewController {

    @IBAction func vkAuthButton(_ sender: Any) {
        vkAuth()
    }
    
    @IBAction func skipButton(_ sender: Any) {
        performSegue(withIdentifier: "HealthSegue", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(nextVC(_:)), name: NSNotification.Name(rawValue: "vkDidAutrorize"), object: nil)
    }
    
    func vkAuth() {
        VK.logIn()
    }

    @objc func nextVC(_ note: Notification) {
        performSegue(withIdentifier: "HealthSegue", sender: nil)
    }
    
}

