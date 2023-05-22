//
//  MetricsView.swift
//  B-Kuik Watch App
//
//  Created by Deka Primatio on 22/05/23.
//

import SwiftUI
import Foundation

struct MetricsView: View {
    //MARK: - PROPERTIES
    
    //MARK: - BODY
    var body: some View {
        VStack(alignment: .leading) {
            ElapsedTimeView(
                elapsedTime: 3 * 60 + 15.24,
                showSubseconds: true
            ).foregroundColor(Color.yellow)
            
            Text(
                Measurement(
                    value: 47,
                    unit: UnitEnergy.kilocalories
                ).formatted(
                    .measurement(
                        width: .abbreviated,
                        usage: .workout
                    )
                )
            )
            
            Text(
                153.formatted(
                    .number.precision(.fractionLength(0))
                )
                + " bpm"
            )
            
            Text(
                Measurement(
                    value: 515,
                    unit: UnitLength.meters
                ).formatted(
                    .measurement(
                        width: .abbreviated,
                        usage: .road
                    )
                )
            )
        }
        .font(.system(.title, design: .rounded)
            .monospacedDigit()
            .lowercaseSmallCaps()
        )
        .frame(maxWidth: .infinity, alignment: .leading)
        .ignoresSafeArea(edges: .bottom)
        .scenePadding()
    }//: - BODY
}

//MARK: - PREVIEW
struct MetricsView_Previews: PreviewProvider {
    static var previews: some View {
        MetricsView()
    }
}
