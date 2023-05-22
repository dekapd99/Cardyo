//
//  ContentView.swift
//  B-Kuik Watch App
//
//  Created by Deka Primatio on 22/05/23.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var workoutManager: WorkoutManager
    
    var workoutTypes: [HKWorkoutActivityType] = [.cycling, .jumpRope, .running, .badminton, .soccer]
    
    //MARK: - BODY
    var body: some View {
        List(workoutTypes) { workoutType in
            NavigationLink(
                workoutType.name,
                destination: Text(workoutType.name),
                tag: workoutType,
                selection: $workoutManager.selectedWorkout
            ).padding(
                EdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 5)
            )
        }
        .listStyle(.carousel)
        .navigationBarTitle("B-Kuik")
        .onAppear {
            workoutManager.requestAuthorization()
        }
    }//: - BODY
}

//MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
