//
//  ActivityRingsView.swift
//  B-Kuik WatchKit App
//
//  Created by Deka Primatio on 23/05/23.
//  Copyright © 2023 Apple. All rights reserved.
//

import Foundation
import HealthKit
import SwiftUI

struct ActivityRingsView: WKInterfaceObjectRepresentable {
    //Access Health-Related Data from the HealthKit
    let healthStore: HKHealthStore
    
    //MARK: - CREATE ACTUAL INTERFACE OBJECT
    func makeWKInterfaceObject(context: Context) -> some WKInterfaceObject {
        let activityRingsObject = WKInterfaceActivityRing() //Store the object in this constant
        
        //Get the Current Date and Setup a Predicate
        let calendar = Calendar.current
        var components = calendar.dateComponents([.era, .year, .month, .day], from: Date())
        components.calendar = calendar
        let predicate = HKQuery.predicateForActivitySummary(with: components)
        
        //This query is used to Fetch Activity Summary Data from HealthKit for the Current Date
        let query = HKActivitySummaryQuery(predicate: predicate) { query, summaries, error in
            
            //Update the Activity Rings with the Fetched Summary Data
            DispatchQueue.main.async {
                activityRingsObject.setActivitySummary(summaries?.first, animated: true)
            }
        }
        
        //When the 'query' above is Complete, the result is returned in the 'summaries'
        healthStore.execute(query)
        return activityRingsObject
    }
    
    //MARK: - INTERFACE OBJECT UPDATE
    func updateWKInterfaceObject(_ wkInterfaceObject: WKInterfaceObjectType, context: Context) {
        
    }
}
