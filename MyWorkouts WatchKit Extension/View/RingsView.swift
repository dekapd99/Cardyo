//
//  RingsView.swift
//  B-Kuik WatchKit App
//
//  Created by Deka Primatio on 25/05/23.
//  Copyright © 2023 Apple. All rights reserved.
//

import SwiftUI

struct RingsView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var workoutManager: WorkoutViewModel
    
    //MARK: - BODY
    var body: some View {
        
        //MARK: - MAIN WRAPPER (VSTACK)
        VStack {
            Text("Activity Rings")
                .fontWeight(.semibold)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color("ColorBlueberryDark"), Color("ColorBlueberryLight")]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                )
            
            Divider()
                .padding(.vertical)
            
            //MARK: - ACTIVITY RINGS RESULTS
            ActivityRingsView(healthStore: workoutManager.healthStore)
                .frame(width: 120, height: 120)
        }
        .padding(.top, 35)
    }//: - BODY
    
}

//MARK: - PREVIEW
struct RingsView_Previews: PreviewProvider {
    static var previews: some View {
        RingsView().environmentObject(WorkoutViewModel())
    }
}
