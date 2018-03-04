//
//  ProfileViewController.swift
//  PP
//
//  Created by Алексей on 03.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit
import SwiftyVK
import HealthKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet var predictionValues: [UILabel]!
    
    @IBOutlet var categoriesLabels: [UILabel]!
    
    let categories = ["Вегетарианское", "Фитнес", "10 минут", "Классическое", "Премиум", "Праздничное"]
    
    @IBAction func switchHealthKitAccess(_ sender: UISwitch) {
    }
    
    @IBAction func switchVKLogin(_ sender: UIButton) {
        VK.logOut()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Профиль"
        
        for i in 0..<categories.count {
            self.predictionValues[i].text = "\(String(format: "%.2f%%",(User.predictions[i] * 100)))"
            self.categoriesLabels[i].text = categories[i]
            
        }
        self.fillVKData()
    }

    func fillVKData() {
        let url = URL(string: User.linkProfileImage)
        if let data = try? Data(contentsOf: url!) {
            let image = UIImage(data : data)
            self.userPhotoImageView.image = image?.circle
        } else {
            self.userPhotoImageView.isHidden = true
        }
        self.userNameLabel.text = "\(User.firstName) \(User.lastName)"
    }
}
