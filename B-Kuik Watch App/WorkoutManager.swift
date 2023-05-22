//
//  WorkoutManager.swift
//  B-Kuik Watch App
//
//  Created by Deka Primatio on 22/05/23.
//

import Foundation
import HealthKit

class WorkoutManager: NSObject, ObservableObject {
    var selectedWorkout: HKWorkoutActivityType? {
        didSet {
            guard let selectedWorkout = selectedWorkout else { return }
            startWorkout(workoutType: selectedWorkout)
        }
    }
    
    let healthStore = HKHealthStore()
    var session: HKWorkoutSession?
    var builder: HKLiveWorkoutBuilder?
    
    func startWorkout(workoutType: HKWorkoutActivityType) {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = workoutType
        configuration.locationType = .outdoor
        
        do {
            session = try HKWorkoutSession(healthStore: healthStore, configuration: configuration)
            builder = session?.associatedWorkoutBuilder()
        } catch {
            return //Handle Any Exception
        }
        
        builder?.dataSource = HKLiveWorkoutDataSource(
            healthStore: healthStore,
            workoutConfiguration: configuration
        )
        
        //Start the Workout session and begin data collection
        let startDate = Date()
        session?.startActivity(with: startDate)
        builder?.beginCollection(withStart: startDate) { (succes, error) in
            // The workout has started
        }
    }
    
    //MARK: - REQUEST AUTHORIZATION TO ACCESS HEALTHKIT
    func requestAuthorization() {
        // The Quantity Type to Write to the Health Store
        let typesToShare: Set = [
            HKQuantityType.workoutType()
        ]
        
        // The Quantity Type to Read from Health Store
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKQuantityType.quantityType(forIdentifier: .distanceCycling)!,
            HKObjectType.activitySummaryType()
        ]
        
        // Request Authorization for Those Quantity Types
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
            //Error Handling
            
        }
    }
}
