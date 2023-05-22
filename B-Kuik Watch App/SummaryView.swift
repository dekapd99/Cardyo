//
//  SummaryView.swift
//  B-Kuik Watch App
//
//  Created by Deka Primatio on 22/05/23.
//

import SwiftUI
import HealthKit

struct SummaryView: View {
    //MARK: - PROPERTIES
    @State private var durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    
    //MARK: - BODY
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                SummaryMetricView(
                    title: "Total Time",
                    value: durationFormatter.string(from: 30 * 60 + 15) ?? "").accentColor(Color.yellow)
                
                SummaryMetricView(
                    title: "Total Distance",
                    value: Measurement(
                        value: 1625,
                        unit: UnitLength.meters
                    ).formatted(
                        .measurement(
                            width: .abbreviated,
                            usage: .road
                        )
                    )
                ).accentColor(Color.green)
                
                SummaryMetricView(
                    title: "Total Energy",
                    value: Measurement(
                        value: 96,
                        unit: UnitEnergy.kilocalories
                    ).formatted(
                        .measurement(
                            width: .abbreviated,
                            usage: .workout
                        )
                    )
                ).accentColor(Color.pink)
                
                SummaryMetricView(
                    title: "Avg. Heart Rate",
                    value: 143
                        .formatted(
                            .number.precision(
                                .fractionLength(0))
                        )
                ).accentColor(Color.red)
                
                Text("Activity Rings")
                ActivityRingsView(
                    healthStore: HKHealthStore()
                ).frame(width: 50, height: 50)
                
                Button {
                    print("tapped")
                } label: {
                    Text("Done")
                }
            }
            .scenePadding()
        }//: - SCROLLVIEW
        .navigationTitle("Summary")
        .navigationBarTitleDisplayMode(.inline)
        
    }//: - BODY
}

//MARK: - PREVIEW
struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}

struct SummaryMetricView: View {
    var title: String
    var value: String
    
    var body: some View {
        Text(title)
        Text(value)
            .font(.system(.title2,design: .rounded).lowercaseSmallCaps())
            .foregroundColor(.accentColor)
        
        Divider()
    }
}
