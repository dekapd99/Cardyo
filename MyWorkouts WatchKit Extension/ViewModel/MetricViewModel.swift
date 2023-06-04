//
//  MetricModel.swift
//  Cardyo WatchKit App
//
//  Created by Deka Primatio on 04/06/23.
//  Copyright © 2023 Apple. All rights reserved.
//

import SwiftUI

struct MetricViewModel: TimelineSchedule {
    //Properties Starting Point & Indicate Paused / Played Mode
    var startDate: Date
    var isPaused: Bool
    
    init(from startDate: Date, isPaused: Bool) {
        self.startDate = startDate
        self.isPaused = isPaused
    }
    
    //Generate a Sequence of Dates Based on the Provided Start Date and Mode
    func entries(from startDate: Date, mode: TimelineScheduleMode) -> AnyIterator<Date> {
        
        //Initialized with the startDate and a frequency value that depends on the mode (lowFrequency or highFrequency)
        var baseSchedule = PeriodicTimelineSchedule(from: self.startDate,
                                                    by: (mode == .lowFrequency ? 1.0 : 1.0 / 30.0))
            .entries(from: startDate, mode: mode)
        
        //AnyIterator<Date> Allows iterating over a sequence of dates.
        return AnyIterator<Date> {
            guard !isPaused else { return nil }
            return baseSchedule.next()
        }
    }
}
