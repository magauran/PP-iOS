//
//  ProfileViewController.swift
//  PP
//
//  Created by Алексей on 03.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBAction func switchHealthKitAccess(_ sender: UISwitch) {
    }
    
    @IBAction func switchVKLogin(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Профиль"
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
