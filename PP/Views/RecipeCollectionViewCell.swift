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
    
    
    func displayContent(imageURL: String, title: String, time: String) {
        self.imageView.imageFromUrl(urlString: imageURL)
        self.titleLabel.text = title
        self.timeLabel.text = time
    }
 
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
        
    }
    
    
}
