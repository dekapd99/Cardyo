//
//  SummaryView.swift
//  B-Kuik WatchKit App
//
//  Created by Deka Primatio on 23/05/23.
//  Copyright © 2023 Apple. All rights reserved.
//

import Foundation
import HealthKit
import SwiftUI
import WatchKit

struct SummaryView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var workoutManager: WorkoutViewModel
    @Environment(\.dismiss) var dismiss
    @State private var durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    //MARK: - BODY
    var body: some View {
        
        //MARK: - IF ELSE CONDITIONAL STATEMENT
        if workoutManager.workout == nil {
            ProgressView("Saving Workout")
                .navigationBarHidden(true)
        } else {
            //MARK: - SCROLLVIEW & VSTACK WRAPPER
            ScrollView {
                VStack(spacing: 10) {
                    
                    //MARK: - TOTAL TIME (HSTACK)
                    HStack {
                        Image(systemName: "clock")
                            .font(.system(size: 30))
                        
                        VStack (alignment: .leading) {
                            Text("Total Time")
                                .font(.system(size: 14))
                            
                            Divider()
                            
                            //SUMMARY METRIC MODEL FOR WORKOUT TOTAL TIME
                            SummaryMetricModel(value: durationFormatter.string(from: workoutManager.workout?.duration ?? 0.0) ?? "")
                                .font(.system(size: 20, weight: .semibold))
                        }
                    }//: - TOTAL TIME (HSTACK)
                    .padding(8)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color("ColorWatermelonDark"), Color("ColorWatermelonLight")]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    )
                    
                    //MARK: - TOTAL DISTANCE (HSTACK)
                    HStack {
                        Image(systemName: "lines.measurement.horizontal")
                            .font(.system(size: 30))
                        
                        VStack (alignment: .leading) {
                            Text("Total Distance")
                                .font(.system(size: 14))
                            
                            Divider()
                            
                            //SUMMARY METRIC MODEL FOR WORKOUT TOTAL DISTANCE
                            SummaryMetricModel(value: Measurement(value: workoutManager.workout?.totalDistance?.doubleValue(for: .meter()) ?? 0,unit: UnitLength.meters).formatted(.measurement(width: .abbreviated, usage: .road, numberFormatStyle: .number.precision(.fractionLength(1)))))
                                .font(.system(size: 20, weight: .semibold))

                        }
                    }//: - TOTAL DISTANCE (HSTACK)
                    .padding(8)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color("ColorPearDark"), Color("ColorPearLight")]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    )
                    
                    //MARK: - CALORIES BURNED (HSTACK)
                    HStack {
                        Image(systemName: "flame")
                            .font(.system(size: 30))
                        
                        VStack (alignment: .leading) {
                            Text("Calories Burned")
                                .font(.system(size: 14))
                            
                            Divider()
                            
                            //SUMMARY METRIC MODEL FOR WORKOUT CALORIES BURNED
                            SummaryMetricModel(value: Measurement(value: workoutManager.workout?.totalEnergyBurned?.doubleValue(for: .kilocalorie()) ?? 0,unit: UnitEnergy.kilocalories)
                                .formatted(.measurement(width: .abbreviated,usage: .workout, numberFormatStyle: .number.precision(.fractionLength(0)))))
                                .font(.system(size: 20, weight: .semibold))
                        }
                    }//: - CALORIES BURNED (HSTACK)
                    .padding(8)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color("ColorLemonDark"), Color("ColorLemonLight")]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    )
                    
                    //MARK: - AVG. HEART RATE (HSTACK)
                    HStack {
                        Image(systemName: "heart")
                            .font(.system(size: 30))
                        
                        VStack (alignment: .leading) {
                            Text("Avg. Heart Rate")
                                .font(.system(size: 14))
                            
                            Divider()
                            
                            //SUMMARY METRIC MODEL FOR WORKOUT AVG. HEART RATE
                            SummaryMetricModel(value: workoutManager.averageHeartRate.formatted(.number.precision(.fractionLength(0))) + " bpm")
                                .font(.system(size: 20, weight: .semibold))
                        }
                    }//: - AVG. HEART RATE (HSTACK)
                    .padding(8)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color("ColorAppleDark"), Color("ColorAppleLight")]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    )
                }//: - VSTACK WRAPPER
                
                .scenePadding()
            }//: - SCROLLVIEW
            .navigationTitle("Summary")
            .navigationBarTitleDisplayMode(.inline)
            
        }//: IF ELSE CONDITIONAL STATEMENT
        
    }//: - BODY
}
