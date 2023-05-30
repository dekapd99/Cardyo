//
//  SummaryPagingView.swift
//  B-Kuik WatchKit App
//
//  Created by Deka Primatio on 25/05/23.
//  Copyright © 2023 Apple. All rights reserved.
//

import SwiftUI

struct SummaryPagingView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var workoutManager: WorkoutManager
    @Environment(\.isLuminanceReduced) var isLuminanceReduced
    @State private var selection: SummaryTab = .summary
    
    enum SummaryTab {
        case ring, summary, end
    }
    
    //MARK: - BODY
    var body: some View {
        TabView(selection: $selection) {
            RingsView().tag(SummaryTab.ring)
            SummaryView().tag(SummaryTab.summary)
//            EndWorkoutView().tag(SummaryTab.end)
        }
        .navigationTitle(workoutManager.selectedWorkout?.name ?? "")
        .navigationBarBackButtonHidden(true)
        .onChange(of: workoutManager.running) { _ in
            displaySummaryView()
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: isLuminanceReduced ? .never : .automatic))
        .onChange(of: isLuminanceReduced) { _ in
            displaySummaryView()
        }
    }
    
    private func displaySummaryView() {
        withAnimation {
            selection = .summary
        }
    }
}

//MARK: - PREVIEW
struct SummaryPagingView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryPagingView().environmentObject(WorkoutManager())
    }
}
