//
//  StartViewController.swift
//  PP
//
//  Created by Алексей on 03.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBAction func vkAuthButton(_ sender: Any) {
        vkAuth()
    }
    
    @IBAction func skipButton(_ sender: Any) {
        performSegue(withIdentifier: "HealthSegue", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func vkAuth() {
        performSegue(withIdentifier: "HealthSegue", sender: nil)
    }

    
}

