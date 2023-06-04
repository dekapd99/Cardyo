//
//  ElapsedTimerViewModel.swift
//  Cardyo WatchKit App
//
//  Created by Deka Primatio on 04/06/23.
//  Copyright © 2023 Apple. All rights reserved.
//

import SwiftUI

class TimeFormatterViewModel: Formatter {
    //Format the time interval into minutes and seconds
    let componentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    var showSubseconds = true //Subseconds in the formatted string
    
    //Converting the Provided Value (a time interval) into a Formatted String
    override func string(for value: Any?) -> String? {
        guard let time = value as? TimeInterval else {
            return nil
        }
        
        guard let formattedString = componentsFormatter.string(from: time) else {
            return nil
        }
        
        if showSubseconds {
            let hundredths = Int((time.truncatingRemainder(dividingBy: 1)) * 100)
            let decimalSeparator = Locale.current.decimalSeparator ?? ":"
            return String(format: "%@%@%0.2d", formattedString, decimalSeparator, hundredths)
        }
        
        return formattedString
    }
}
