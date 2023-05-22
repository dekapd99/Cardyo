//
//  ActivityRingsView.swift
//  B-Kuik Watch App
//
//  Created by Deka Primatio on 22/05/23.
//

import Foundation
import HealthKit
import SwiftUI

struct ActivityRingsView: WKInterfaceObjectRepresentable {
    
    func updateWKInterfaceObject(_ wkInterfaceObject: WKInterfaceObjectType, context: Context) {
        print("test")
    }
    
    let healthStore: HKHealthStore
    
    func makeWKInterfaceObject(context: Context) -> some WKInterfaceObject {
        let activityRingsObject = WKInterfaceActivityRing()
        
        let calendar = Calendar.current
        var components = calendar.dateComponents([.era, .year, .month, .day], from: Date())
        components.calendar = calendar
        
        let predicate = HKQuery.predicateForActivitySummary(with: components)
        
        let query = HKActivitySummaryQuery(predicate: predicate) { query, summaries, error in
            DispatchQueue.main.async {
                activityRingsObject.setActivitySummary(summaries?.first, animated: true)
            }
        }
        
        healthStore.execute(query)
        
        return activityRingsObject
    }
}
