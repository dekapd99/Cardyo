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
    @EnvironmentObject var workoutManager: WorkoutViewModel
    @Environment(\.isLuminanceReduced) var isLuminanceReduced
    @State private var selection: SummaryTab = .summary
    
    //MARK: - BODY
    var body: some View {
        
        //MARK: - TABVIEWS (RINGS, SUMMARY, AND ENDWORKOUT)
        TabView(selection: $selection) {
            RingsView().tag(SummaryTab.ring)
            SummaryView().tag(SummaryTab.summary)
            EndWorkoutView().tag(SummaryTab.end)
        }//: - TABVIEWS (RINGS, SUMMARY, AND ENDWORKOUT)
        .navigationTitle(workoutManager.selectedWorkout?.name ?? "")
        .navigationBarBackButtonHidden(true)
        .onChange(of: workoutManager.running) { _ in
            displaySummaryView()
        }//onChange Workout Manager Running Session
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: isLuminanceReduced ? .never : .automatic))
        .onChange(of: isLuminanceReduced) { _ in
            displaySummaryView()
        }//onChange LuminanceReduced
        
    }//: - BODY
    
    //MARK: - SUMMARY DISPLAY DEFAULT (PRIVATE FUNCTION)
    private func displaySummaryView() {
        withAnimation {
            selection = .summary
        }
    }//: - SUMMARY DISPLAY DEFAULT (PRIVATE FUNCTION)
    
}

//MARK: - PREVIEW
struct SummaryPagingView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryPagingView().environmentObject(WorkoutViewModel())
    }
}
