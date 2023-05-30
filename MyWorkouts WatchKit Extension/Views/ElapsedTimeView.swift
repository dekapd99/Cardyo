//
//  ElapsedTimeView.swift
//  B-Kuik WatchKit App
//
//  Created by Deka Primatio on 23/05/23.
//  Copyright © 2023 Apple. All rights reserved.
//

import SwiftUI

struct ElapsedTimeView: View {
    var elapsedTime: TimeInterval = 0
    var showSubseconds: Bool = true
    @State private var timeFormatter = ElapsedTimeFormatter()
    
    var body: some View {
        Text(NSNumber(value: elapsedTime), formatter: timeFormatter)
            .font(.system(size: 30, weight: .semibold))
            .frame(width: 150)
            .onChange(of: showSubseconds) {
                timeFormatter.showSubseconds = $0
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color("ColorWatermelonDark"), Color("ColorWatermelonLight")]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .clipShape(RoundedRectangle(cornerRadius: 8))
            )
    }
}

class ElapsedTimeFormatter: Formatter {
    let componentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    var showSubseconds = true
    
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

struct ElapsedTime_Previews: PreviewProvider {
    static var previews: some View {
        ElapsedTimeView()
    }
}
