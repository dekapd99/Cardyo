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
    @EnvironmentObject var workoutViewModel: WorkoutViewModel
    
    //MARK: - BODY
    var body: some View {
        
        //MARK: - MAIN WRAPPER (VSTACK)
        VStack(spacing: 30) {
            
            //MARK: - PAUSE & RESUME BUTTON (VSTACK)
            VStack {
                
                HStack {
                    Button {
                        workoutViewModel.togglePause()
                        WKInterfaceDevice.current().play(.notification)
                    } label: {
                        Text(workoutViewModel.running ? "Pause" : "Resume")
                            .padding(.horizontal, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color("ColorGrapefruitDark"))
                                    .frame(height: 30)
                            )
                        
                        Spacer()
                        
                        Image(systemName: workoutViewModel.running ? "pause" : "play")
                            .padding(.horizontal, 10)
                            .background(
                                Circle()
                                    .fill(Color("ColorGrapefruitDark"))
                                    .frame(width: 30, height: 30)
                            )
                    }//: - LABEL BUTTON
                }// - HSTACK WRAPPER (PAUSE & PLAY)
                
            }//: - PAUSE & PLAY (VSTACK)
            
            //MARK: - STOP BUTTON (VSTACK)
            VStack {
                HStack {
                    Button {
                        workoutViewModel.endWorkout()
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
                    }//: - LABEL BUTTON
                }// - HSTACK WRAPPER (STOP & XMARK)
            }//: - STOP BUTTON (VSTACK)
            
        }//: - MAIN WRAPPER (VSTACK)
    }//: - BODY
}

//MARK: - PREVIEW
struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView().environmentObject(WorkoutViewModel())
    }
}
