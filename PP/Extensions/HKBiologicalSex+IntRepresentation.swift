//
//  HKBiologicalSex+IntRepresentation.swift
//  PP
//
//  Created by Алексей on 03.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//


import HealthKit

extension HKBiologicalSex {
  
  var intRepresentation: Int {
    switch self {
    case .notSet: return 0
    case .female: return 0
    case .male: return 1
    case .other: return 0
    }
  }
}
