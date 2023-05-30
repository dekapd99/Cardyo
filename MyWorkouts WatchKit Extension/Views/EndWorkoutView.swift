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
    @EnvironmentObject var workoutManager: WorkoutManager
    @Environment(\.dismiss) var dismiss
    @State private var navigateToStartView = false
    
    //MARK: - BODY
    var body: some View {
        VStack(spacing: 10) {
            Text("Do you want to try Other Exercise")
                .multilineTextAlignment(.center)
            
            Button("Done") {
                dismiss()
            }
        }
    }//: - BODY
}

//MARK: - PREVIEW
struct EndWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        EndWorkoutView()
    }
}
