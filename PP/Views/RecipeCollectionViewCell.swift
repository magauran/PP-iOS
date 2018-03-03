//
//  RecipeCollectionViewCell.swift
//  PP
//
//  Created by Алексей on 03.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    func displayContent(image: UIImage, title: String, time: String) {
        self.imageView.image = image
        self.titleLabel.text = title
        self.timeLabel.text = time
    }
    
    
}
