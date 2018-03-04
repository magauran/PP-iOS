//
//  InstructionTableViewCell.swift
//  PP
//
//  Created by Алексей on 04.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class InstructionTableViewCell: UITableViewCell {

    @IBOutlet weak var stepLabel: UILabel!
    
    @IBOutlet weak var recipeStepTextLabel: UILabel!
    
    func displayContent(text: String, step: Int) {
        self.stepLabel.text = "Шаг \(step)"
        self.recipeStepTextLabel.text = text
    }
    
}
