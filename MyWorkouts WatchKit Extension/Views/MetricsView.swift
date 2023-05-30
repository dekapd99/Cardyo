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
    @EnvironmentObject var workoutManager: WorkoutManager
    
    var body: some View {
        TimelineView(MetricsTimelineSchedule(from: workoutManager.builder?.startDate ?? Date(),
                                             isPaused: workoutManager.session?.state == .paused)) { context in
            
            VStack(spacing: 10) {
                HStack {
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
                    
                    //MARK: - DISTANCE
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
                
                //MARK: - TIMER
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
            }
            .frame(maxWidth: .infinity)
            .ignoresSafeArea(edges: .bottom)
            .scenePadding()
        }
    }
}

struct MetricsView_Previews: PreviewProvider {
    static var previews: some View {
        MetricsView().environmentObject(WorkoutManager())
    }
}

private struct MetricsTimelineSchedule: TimelineSchedule {
    var startDate: Date
    var isPaused: Bool
    
    init(from startDate: Date, isPaused: Bool) {
        self.startDate = startDate
        self.isPaused = isPaused
    }
    
    func entries(from startDate: Date, mode: TimelineScheduleMode) -> AnyIterator<Date> {
        var baseSchedule = PeriodicTimelineSchedule(from: self.startDate,
                                                    by: (mode == .lowFrequency ? 1.0 : 1.0 / 30.0))
            .entries(from: startDate, mode: mode)
        
        return AnyIterator<Date> {
            guard !isPaused else { return nil }
            return baseSchedule.next()
        }
    }
}
