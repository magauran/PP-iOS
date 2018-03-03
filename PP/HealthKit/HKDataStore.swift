//
//  HKDataStore.swift
//  PP
//
//  Created by Алексей on 03.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation
import HealthKit

class HKDataStore {
    
    class func getBirthday(completion: @escaping (Bool) -> Void) {
        let healthKitStore = HKHealthStore()
        
        if let birthdayComponents = try? healthKitStore.dateOfBirthComponents() {
            
            let calendar = Calendar.current
            let isBirthday = calendar.isDateInWeekend(birthdayComponents.date!)
            
            completion(isBirthday)
            return
        }
        completion(false)
    }
    
    class func getAge(completion: @escaping (Int) -> Void) {
        let healthKitStore = HKHealthStore()
        
        if let birthdayComponents = try? healthKitStore.dateOfBirthComponents() {
            let today = Date()
            let calendar = Calendar.current
            let todayDateComponents = calendar.dateComponents([.year],
                                                              from: today)
            let thisYear = todayDateComponents.year!
            let age = thisYear - birthdayComponents.year!
            completion(age)
            return
        }
        completion(0)
    }
    
    class func getSex(completion: @escaping (Int) -> Void) {
        let healthKitStore = HKHealthStore()
        
        if let biologicalSex = try? healthKitStore.biologicalSex() {
            let unwrappedBiologicalSex = biologicalSex.biologicalSex
            let biologicalSexIntValue = unwrappedBiologicalSex.intRepresentation
            completion(biologicalSexIntValue)
            return
        }
        completion(0)
    }
    
    
    class func getWeight(completion: @escaping (Double) -> Void) {
        let healthStore = HKHealthStore()
        
        let weightQuantityType = HKQuantityType.quantityType(forIdentifier: .bodyMass)!
        
        let now = Date()
        let start = Date(timeIntervalSince1970: 0)
        let startOfDay = Calendar.current.startOfDay(for: start)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        var weight = Double()
        
        let query = HKSampleQuery(sampleType: weightQuantityType, predicate: predicate, limit: 0, sortDescriptors: nil) { ( _, results, error) in
            
            if let error = error {
                print("Error: ", error.localizedDescription)
            }
            
            let res = results as! [HKQuantitySample]
            if let weightValue = res.last?.quantity.doubleValue(for: HKUnit.gram()) {
                weight = weightValue / 1000
            }
            
            completion(weight)
        }
        
        healthStore.execute(query)
    }
    
    
    class func getSteps(completion: @escaping ([Steps]) -> Void) {
        let healthStore = HKHealthStore()
        
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let start = now.adding(months: -1)!
        let startOfDay = Calendar.current.startOfDay(for: start)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        var steps = [Steps]()
        
        let query = HKSampleQuery(sampleType: stepsQuantityType, predicate: predicate, limit: 0, sortDescriptors: nil) { ( _, results, error) in
            
            if let error = error {
                print("Error: ", error.localizedDescription)
            }
            
            for i in results  as! [HKQuantitySample] {
                let count = Int(i.quantity.doubleValue(for: HKUnit.count()))
                
                let date = i.startDate
                steps.append(Steps(count, date))
            }
            
            completion(steps)
        }
        
        healthStore.execute(query)
        
    }
    
}
