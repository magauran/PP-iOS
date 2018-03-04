//
//  IngredientTableViewCell.swift
//  PP
//
//  Created by Алексей on 04.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var countLabel: UILabel!

    func displayContent(name: String, count: String) {
        self.nameLabel.text = name
        self.countLabel.text = count
    }


}
