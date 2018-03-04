//
//  HealthAccessViewController.swift
//  PP
//
//  Created by Алексей on 03.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit
import SwiftyJSON

class HealthAccessViewController: UIViewController {

    var weight = Double()
    var sex = Int()
    var isBirthday = Int()
    var isActive = Int()
    var isSporty = Int()
    var age = Int()
    
    
    @IBAction func yesButton(_ sender: Any) {
        healthKitAuth()
    }
    
    @IBAction func noButton(_ sender: Any) {
        performSegue(withIdentifier: "AllRecipesSegue", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func healthKitAuth() {
        
        HKSetupAssistant.authorizeHealthKit { (authorized, error) in
            
            guard authorized else {
                let baseMessage = "HealthKit Authorization Failed"
                if let error = error {
                    print("\(baseMessage). Reason: \(error.localizedDescription)")
                } else {
                    print(baseMessage)
                }
                return
            }
            print("HealthKit Successfully Authorized.")
            self.loadHKData()
        }
        
    }
    
    func loadHKData() {
        HKDataStore.getSteps() { result in
            var monthSteps = Array<Int>.init(repeating: 0, count: 31)
            let calendar = Calendar.current
            for i in result {
                let date1 = calendar.startOfDay(for: i.date)
                let date2 = calendar.startOfDay(for: Date())
                
                let unitFlags = Set<Calendar.Component>([ .day])
                let components = calendar.dateComponents(unitFlags, from: date1, to: date2)
                let dayAgo = components.day!
                monthSteps[dayAgo] += i.count
            }
            
            var numberOfDaysWhenStepsMoreThan8000 = 0
            for i in monthSteps {
                if i > 8000 {
                    numberOfDaysWhenStepsMoreThan8000 += 1
                }
            }
            self.isSporty = Double(numberOfDaysWhenStepsMoreThan8000) / Double(31) > 0.65 ? 1 : 0
            
            let avgArrayValue = result.map { $0.count }.reduce(0, +) / result.count
            self.isSporty = self.isActive * (avgArrayValue > 100 ? 1 : 0)
            self.getWeight()
            
        }
        
    }
    
    func getWeight() {
        
        HKDataStore.getWeight() { result in
            self.weight = result
            self.getSex()
        }
    }
    
    func getSex() {
        HKDataStore.getSex() { result in
            self.sex = result
            self.getAge()
        }
    }
    
    func getAge() {
        HKDataStore.getAge() { result in
            self.age = result
            self.getBirthday()
        }
    }
    
    func getBirthday() {
        HKDataStore.getBirthday() { result in
            self.isBirthday = result
            let json: JSON = ["sex": self.sex,
                              "age": self.age,
                              "weight": self.weight,
                              "isBirthday": self.isBirthday,
                              "isActive": self.isActive,
                              "isSporty": self.isSporty,
                              "isBirthday": self.isBirthday,
                              "subscriptions": User.subscriptions,
                              "relation": User.relation,
                              "isBreakfast": self.isBreakfast,
                              "occupation": User.occupation
                              ]
            print(json)
            //PPApiWorker.getRecomendedRecipies(body: json)
            PPApiWorker.getRecipiesByCategory(category: 0)
            self.performSegue(withIdentifier: "AllRecipesSegue", sender: nil)
        }
    }
    
    var isBreakfast: Int {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        return (hour > 3 && hour < 13) ? 1 : 0
    }
    
}
