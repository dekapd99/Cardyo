//
//  ElapsedTimeView.swift
//  B-Kuik WatchKit App
//
//  Created by Deka Primatio on 23/05/23.
//  Copyright © 2023 Apple. All rights reserved.
//

import SwiftUI

struct ElapsedTimeView: View {
    //MARK: - PROPERTIES
    var elapsedTime: TimeInterval = 0
    var showSubseconds: Bool = true
    @State private var timeFormatter = TimeFormatterViewModel()
    
    //MARK: - BODY
    var body: some View {
        //Timer Text
        Text(NSNumber(value: elapsedTime), formatter: timeFormatter)
            .font(.system(size: 30, weight: .semibold))
            .frame(width: 150)
            .onChange(of: showSubseconds) {
                timeFormatter.showSubseconds = $0
            }//: - onChange
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color("ColorWatermelonDark"), Color("ColorWatermelonLight")]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .clipShape(RoundedRectangle(cornerRadius: 8))
            )//: - Background Shape & Color
    }//: - BODY
}

//MARK: - PREVIEW
struct ElapsedTime_Previews: PreviewProvider {
    static var previews: some View {
        ElapsedTimeView()
    }
}
