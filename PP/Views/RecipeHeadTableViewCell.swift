//
//  RecipeHeadTableViewCell.swift
//  PP
//
//  Created by Алексей on 04.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class RecipeHeadTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeTimeLabel: UILabel!

    func displayContent(image: UIImage, title: String, time: String) {
        self.recipeImageView.image = image
        self.recipeTitleLabel.text = title
        self.recipeTimeLabel.text = time
    }
}
