//
//  AllRecipesViewController.swift
//  PP
//
//  Created by Алексей on 03.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit
import Foundation
import NVActivityIndicatorView


class AllRecipesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet var categoriesButtons: [UIButton]!
    
    var selectedCategory = 0
    var recipes = [Recipe]()
    var recipesCopy = [Recipe]()
    
    var choosenImage = UIImage.init()
    
    let defaultFont = UIFont(name: "Helvetica", size: 15)
    let selectedFont = UIFont(name: "Helvetica Bold", size: 15)
    
    private let refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Рецепты"
        self.collectionView.register(UINib(nibName: "RecipeCell", bundle: nil), forCellWithReuseIdentifier: "recipeCellId")
        self.collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc func refreshData() {
        //self.showActivityIndicatory()
        self.refreshControl.beginRefreshing()
        self.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCellId", for: indexPath) as! RecipeCollectionViewCell
      
        cell.displayContent(imageURL: recipes[indexPath.row].photo, title: recipes[indexPath.row].title, time: recipes[indexPath.row].time)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width / 2 - 5, height:self.view.frame.size.width / 2 + 80)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cv = collectionView.cellForItem(at: indexPath) as! RecipeCollectionViewCell
        self.choosenImage = cv.imageView.image!
        performSegue(withIdentifier: "RecipeSegue", sender: recipes[indexPath.row])
        
    }
    
    
    @IBAction func chooseCategory(_ sender: UIButton) {
        self.categoriesButtons[selectedCategory].titleLabel?.font = self.defaultFont
        self.categoriesButtons[sender.tag].titleLabel?.font = self.selectedFont
        self.selectedCategory = sender.tag
        
        if sender.tag == 0 {
            self.showActivityIndicatory()
            self.recipes = self.recipesCopy
            self.collectionView.reloadData()
            self.hideActivityIndicatory()
        } else {
            self.showActivityIndicatory()
            PPApiWorker.getRecipesByCategory(category: sender.tag - 1) {
                result in
                self.recipesCopy = self.recipes
                self.recipes = result
                self.collectionView.reloadData()
                self.hideActivityIndicatory()
            }
        }
        
    }
 
    
    func reloadData() {
        
        if self.selectedCategory == 0 {
            self.recipes = self.recipesCopy
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
            
        } else {
            
            PPApiWorker.getRecipesByCategory(category: self.selectedCategory - 1) {
                result in
                
                //DispatchQueue.main.async {
                    self.recipesCopy = self.recipes
                    self.recipes = result
                    self.collectionView.reloadData()
                    self.refreshControl.endRefreshing()
                   // self.hideActivityIndicatory()
                //}
                
            }
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "RecipeSegue") {
            let rec = sender as! Recipe
            let secondViewController = segue.destination as! RecipeTableViewController
            secondViewController.image = self.choosenImage
            secondViewController.recipeTime = rec.time
            secondViewController.recipeTitle = rec.title
            secondViewController.ingredients = rec.ingredients
            secondViewController.instructions = rec.instructions
            
        }
    }

}
