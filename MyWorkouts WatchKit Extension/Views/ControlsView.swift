//
//  ControlsView.swift
//  B-Kuik WatchKit App
//
//  Created by Deka Primatio on 23/05/23.
//  Copyright © 2023 Apple. All rights reserved.
//

import SwiftUI

struct ControlsView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var workoutManager: WorkoutManager
    let hapticImpact = WKHapticType.click
    
    //MARK: - BODY
    var body: some View {
        
        //MARK: - MAIN WRAPPER (VSTACK)
        VStack(spacing: 30) {
            
            //MARK: - PAUSE & RESUME BUTTON
            VStack {
                HStack {
                    Button {
                        workoutManager.togglePause()
                        WKInterfaceDevice.current().play(.notification)
                    } label: {
                        Text(workoutManager.running ? "Pause" : "Resume")
                            .padding(.horizontal, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color("ColorGrapefruitDark"))
                                    .frame(height: 30)
                            )
                        
                        Spacer()
                        
                        Image(systemName: workoutManager.running ? "pause" : "play")
                            .padding(.horizontal, 10)
                            .background(
                                Circle()
                                    .fill(Color("ColorGrapefruitDark"))
                                    .frame(width: 30, height: 30)
                            )
                    }//: - LABEL BUTTON
                }
            }//: - PAUSE & PLAY (VSTACK)
            
            //MARK: - STOP BUTTON
            VStack {
                HStack {
                    Button {
                        workoutManager.endWorkout()
                        WKInterfaceDevice.current().play(.notification)
                    } label: {
                        Text("Stop")
                            .padding(.horizontal, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color("ColorAppleDark"))
                                    .frame(height: 30)
                            )
                        Spacer()
                        
                        Image(systemName: "xmark")
                            .padding(.horizontal, 10)
                            .background(
                                Circle()
                                    .fill(Color("ColorAppleDark"))
                                    .frame(height: 30)
                            )
                    }
                }
            }//: - STOP BUTTON (VSTACK)
            
        }//: - MAIN WRAPPER (VSTACK)
    }//: - BODY
}

//MARK: - PREVIEW
struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView().environmentObject(WorkoutManager())
    }
}
