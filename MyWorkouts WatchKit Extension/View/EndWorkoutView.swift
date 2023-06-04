//
//  EndWorkoutView.swift
//  B-Kuik WatchKit App
//
//  Created by Deka Primatio on 25/05/23.
//  Copyright © 2023 Apple. All rights reserved.
//

import Foundation
import HealthKit
import SwiftUI
import WatchKit

struct EndWorkoutView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var workoutManager: WorkoutViewModel
    @Environment(\.presentationMode) var presentationMode
    
    //MARK: - BODY
    var body: some View {
        
        //MARK: - MAIN WRAPPER (VSTACK)
        VStack(spacing: 10) {
            Text("Congratulation \nYou've Done It")
                .multilineTextAlignment(.center)
            
            Button("Back to Home") {
                presentationMode.wrappedValue.dismiss()
            }
        }//: - MAIN WRAPPER (VSTACK)
        
    }//: - BODY
}

//MARK: - PREVIEW
struct EndWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        EndWorkoutView()
    }
}
