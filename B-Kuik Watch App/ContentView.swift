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
    var workoutTypes: [HKWorkoutActivityType] = [.jumpRope, .running, .badminton, .soccer, .cycling]
    
    //MARK: - BODY
    var body: some View {
        List(workoutTypes) { workoutTypes in
            NavigationLink(
                workoutTypes.name,
                destination: Text(workoutTypes.name)
            ).padding(
                EdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 5)
            )
        }
        .listStyle(.carousel)
        .navigationTitle("B-Kuik")
    }//: - BODY
}

//MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
