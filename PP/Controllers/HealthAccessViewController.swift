//
//  HealthAccessViewController.swift
//  PP
//
//  Created by Алексей on 03.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class HealthAccessViewController: UIViewController {

    @IBAction func yesButton(_ sender: Any) {
        healthKitAuth()
    }
    
    @IBAction func noButton(_ sender: Any) {
        performSegue(withIdentifier: "AllRecipesSegue", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func healthKitAuth() {
        performSegue(withIdentifier: "AllRecipesSegue", sender: nil)
    }
}
