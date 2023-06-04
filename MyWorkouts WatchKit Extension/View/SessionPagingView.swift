//
//  SessionPagingView.swift
//  B-Kuik WatchKit App
//
//  Created by Deka Primatio on 23/05/23.
//  Copyright © 2023 Apple. All rights reserved.
//

import SwiftUI
import WatchKit

struct SessionPagingView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var workoutManager: WorkoutViewModel
    @Environment(\.isLuminanceReduced) var isLuminanceReduced
    @State private var selection: WorkoutTab = .metrics

    //MARK: - BODY
    var body: some View {
        
        //MARK: - TABVIEWS (CONTROL, METRIC, AND NOWPLAYING)
        TabView(selection: $selection) {
            ControlsView().tag(WorkoutTab.controls)
            MetricsView().tag(WorkoutTab.metrics)
            NowPlayingView().tag(WorkoutTab.nowPlaying)
        }//: - TABVIEWS (CONTROL, METRIC, AND NOWPLAYING)
        .navigationTitle(workoutManager.selectedWorkout?.name ?? "")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(selection == .nowPlaying)
        .onChange(of: workoutManager.running) { _ in
            displayMetricsView()
        }//onChange Workout Metrics Running Session
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: isLuminanceReduced ? .never : .automatic))
        .onChange(of: isLuminanceReduced) { _ in
            displayMetricsView()
        }//onChange LuminanceReduced
        
    }//: - BODY

    //MARK: - WORKOUT SESSION DISPLAY DEFAULT (PRIVATE FUNCTION)
    private func displayMetricsView() {
        withAnimation {
            selection = .metrics
        }
    }//: - WORKOUT SESSION DISPLAY DEFAULT (PRIVATE FUNCTION)
    
}

//MARK: - PREVIEW
struct PagingView_Previews: PreviewProvider {
    static var previews: some View {
        SessionPagingView().environmentObject(WorkoutViewModel())
    }
}
