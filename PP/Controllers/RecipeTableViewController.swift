//
//  RecipeTableViewController.swift
//  PP
//
//  Created by Алексей on 04.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class RecipeTableViewController: UITableViewController {

    var image = UIImage(named: "fon1")!
    var recipeTitle = ""
    var recipeTime = ""
    var ingredients = [Ingredient]()
    var instructions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "RecipeHeadTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeHeadCell")
        self.tableView.register(UINib(nibName: "IngredientTableViewCell", bundle: nil), forCellReuseIdentifier: "IngredientCell")
        self.tableView.register(UINib(nibName: "InstructionTableViewCell", bundle: nil), forCellReuseIdentifier: "InstructionCell")
        
        
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + self.ingredients.count + self.instructions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeHeadCell", for: indexPath) as! RecipeHeadTableViewCell
            cell.displayContent(image: image, title: recipeTitle, time: recipeTime)
            return cell
        }
        if indexPath.row <= self.ingredients.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! IngredientTableViewCell
            cell.displayContent(name: ingredients[indexPath.row - 1].name, count: ingredients[indexPath.row - 1].value)
            return cell
        }
        if indexPath.row <= self.ingredients.count + self.instructions.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionCell", for: indexPath) as! InstructionTableViewCell
            cell.displayContent(text: instructions[indexPath.row - self.ingredients.count - 1], step: indexPath.row - self.ingredients.count)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        return cell
    }
 



}
