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
    @EnvironmentObject var workoutManager: WorkoutManager
    @Environment(\.dismiss) var dismiss
    @State private var durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    //MARK: - BODY
    var body: some View {
        if workoutManager.workout == nil {
            ProgressView("Saving Workout")
                .navigationBarHidden(true)
        } else {
            //MARK: - SCROLLVIEW
            ScrollView {
                VStack(spacing: 10) {
                    
                    //MARK: - TOTAL TIME
                    HStack {
                        Image(systemName: "clock")
                            .font(.system(size: 30))
                        
                        VStack (alignment: .leading) {
                            Text("Total Time")
                                .font(.system(size: 14))
                            
                            Divider()
                            
                            SummaryMetricView(value: durationFormatter.string(from: workoutManager.workout?.duration ?? 0.0) ?? "")
                                .font(.system(size: 20, weight: .semibold))
                        }
                    }//: - TOTAL TIME
                    .padding(8)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color("ColorWatermelonDark"), Color("ColorWatermelonLight")]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    )
                    
                    //MARK: - TOTAL DISTANCE
                    HStack {
                        Image(systemName: "lines.measurement.horizontal")
                            .font(.system(size: 30))
                        
                        VStack (alignment: .leading) {
                            Text("Total Distance")
                                .font(.system(size: 14))
                            
                            Divider()
                            
                            SummaryMetricView(value: Measurement(value: workoutManager.workout?.totalDistance?.doubleValue(for: .meter()) ?? 0,unit: UnitLength.meters).formatted(.measurement(width: .abbreviated, usage: .road, numberFormatStyle: .number.precision(.fractionLength(1)))))
                                .font(.system(size: 20, weight: .semibold))

                        }
                    }//: - TOTAL DISTANCE
                    .padding(8)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color("ColorPearDark"), Color("ColorPearLight")]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    )
                    
                    //MARK: - CALORIES BURNED
                    HStack {
                        Image(systemName: "flame")
                            .font(.system(size: 30))
                        
                        VStack (alignment: .leading) {
                            Text("Calories Burned")
                                .font(.system(size: 14))
                            
                            Divider()
                            
                            SummaryMetricView(value: Measurement(value: workoutManager.workout?.totalEnergyBurned?.doubleValue(for: .kilocalorie()) ?? 0,unit: UnitEnergy.kilocalories)
                                .formatted(.measurement(width: .abbreviated,usage: .workout, numberFormatStyle: .number.precision(.fractionLength(0)))))
                                .font(.system(size: 20, weight: .semibold))
                        }
                    }//: - CALORIES BURNED
                    .padding(8)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color("ColorLemonDark"), Color("ColorLemonLight")]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    )
                    
                    //MARK: - AVG. HEART RATE
                    HStack {
                        Image(systemName: "heart")
                            .font(.system(size: 30))
                        
                        VStack (alignment: .leading) {
                            Text("Avg. Heart Rate")
                                .font(.system(size: 14))
                            
                            Divider()
                            
                            SummaryMetricView(value: workoutManager.averageHeartRate.formatted(.number.precision(.fractionLength(0))) + " bpm")
                                .font(.system(size: 20, weight: .semibold))
                        }
                    }//: - AVG. HEART RATE
                    .padding(8)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color("ColorAppleDark"), Color("ColorAppleLight")]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    )
                }
                .scenePadding()
            }
            .navigationTitle("Summary")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SummaryMetricView: View {
    var value: String
    
    var body: some View {
        Text(value)
    }
}
