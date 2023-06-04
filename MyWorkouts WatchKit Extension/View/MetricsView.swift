//
//  MetricsView.swift
//  B-Kuik WatchKit App
//
//  Created by Deka Primatio on 23/05/23.
//  Copyright © 2023 Apple. All rights reserved.
//

import SwiftUI
import HealthKit

struct MetricsView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var workoutManager: WorkoutViewModel
    
    //MARK: - BODY
    var body: some View {
        
        //MARK: - TIMELINE VIEW PAUSE / PLAY SESSION
        TimelineView(MetricViewModel(from: workoutManager.builder?.startDate ?? Date(),
                                             isPaused: workoutManager.session?.state == .paused)) { context in
            
            //MARK: - MAIN WRAPPER (VSTACK)
            VStack(spacing: 10) {
                
                //MARK: - CALORIES & DISTANCE WRAPPER (HSTACK)
                HStack {
                    
                    //MARK: - BURNED CALORIES
                    HStack {
                        Image(systemName: "flame")
                        
                        Text(Measurement(value: workoutManager.activeEnergy, unit: UnitEnergy.kilocalories)
                            .formatted(.measurement(width: .abbreviated, usage: .workout, numberFormatStyle: .number.precision(.fractionLength(0)))))
                    }
                    .font(.system(size: 14, weight: .semibold))
                    .frame(width: 65)
                    .padding(8)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color("ColorLemonDark"), Color("ColorLemonLight")]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    )
                    
                    //MARK: - TOTAL DISTANCE
                    HStack {
                        Image(systemName: "lines.measurement.horizontal")
                        
                        Text(Measurement(value: workoutManager.distance, unit: UnitLength.meters).formatted(.measurement(width: .abbreviated, usage: .road)))
                    }
                    .font(.system(size: 14, weight: .semibold))
                    .frame(width: 65)
                    .padding(8)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color("ColorPearDark"), Color("ColorPearLight")]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    )
                }
                
                //MARK: - ELAPSED TIMER (TOTAL TIME)
                ElapsedTimeView(elapsedTime: workoutManager.builder?.elapsedTime(at: context.date) ?? 0, showSubseconds: context.cadence == .live)
                
                //MARK: - HEART RATE
                HStack {
                    Image(systemName: "heart")
                    
                    Text(workoutManager.heartRate.formatted(.number.precision(.fractionLength(0))) + " BPM")
                }
                .font(.system(size: 14, weight: .semibold))
                .frame(width: 150)
                .padding(8)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color("ColorAppleDark"), Color("ColorAppleLight")]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                )
            }//: - MAIN WRAPPER (VSTACK)
            .frame(maxWidth: .infinity)
            .ignoresSafeArea(edges: .bottom)
            .scenePadding()
            
        }//: - TIMELINE VIEW PAUSE / PLAY SESSION
        
    }//: - BODY
}

//MARK: - PREVIEW
struct MetricsView_Previews: PreviewProvider {
    static var previews: some View {
        MetricsView().environmentObject(WorkoutViewModel())
    }
}
