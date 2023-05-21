//
//  Extension.swift
//  B-Kuik Watch App
//
//  Created by Deka Primatio on 22/05/23.
//

import SwiftUI
import HealthKit

extension HKWorkoutActivityType: Identifiable {
    public var id: UInt {
        rawValue
    }
    
    var name: String {
        switch self {
        case .running:
            return "Running"
            
        case .badminton:
            return "Badminton"
            
        case .cycling:
            return "Cycling"
            
        case .jumpRope:
            return "Jumping Rope"
            
        case .soccer:
            return "Soccer"
            
        default:
            return ""
        }
    }
}

