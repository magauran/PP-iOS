//
//  AllRecipesViewController.swift
//  PP
//
//  Created by Алексей on 03.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit


class AllRecipesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet var categoriesButtons: [UIButton]!
    
    var selectedCategory = 0
    var recipies = [Recipe]()
    
    let defaultFont = UIFont(name: "Helvetica", size: 15)
    let selectedFont = UIFont(name: "Helvetica Bold", size: 15)
    
    var navigationBarIsHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(recipies)
        self.navigationItem.title = "Рецепты"
        self.collectionView.register(UINib(nibName: "RecipeCell", bundle: nil), forCellWithReuseIdentifier: "recipeCellId")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.panGestureRecognizer.velocity(in: self.collectionView).y > 0 {
            UIView.animate(withDuration: 0.2, animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                self.view.setNeedsLayout()
                print("Unhide")
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.view.setNeedsLayout()
                print("Hide")
            })
           

        }

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCellId", for: indexPath) as! RecipeCollectionViewCell
        
        var image = UIImage(named: "fon1")!
        
        let url = URL(string: recipies[indexPath.row].photo)
        if let data = try? Data(contentsOf: url!) {
            image = UIImage(data : data)!
        }
        
        cell.displayContent(image: image, title: recipies[indexPath.row].title, time: recipies[indexPath.row].time)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width / 2 - 5, height:self.view.frame.size.width / 2 + 50)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "RecipeSegue", sender: nil)
    }

    
    @IBAction func chooseCategory(_ sender: UIButton) {
        self.categoriesButtons[selectedCategory].titleLabel?.font = self.defaultFont
        self.categoriesButtons[sender.tag].titleLabel?.font = self.selectedFont
        self.selectedCategory = sender.tag
    }
 
   

}
