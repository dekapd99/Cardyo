//
//  BKuikApp.swift
//  B-Kuik WatchKit App
//
//  Created by Deka Primatio on 23/05/23.
//  Copyright © 2023 Apple. All rights reserved.
//

import SwiftUI

@main
struct CardyoApp: App {
    @StateObject private var workoutViewModel = WorkoutViewModel()

    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                StartView()
            }
            .fullScreenCover(isPresented: $workoutViewModel.showingSummaryView) {
                BreathView()
                    .navigationBarBackButtonHidden(true)
            }
            .environmentObject(workoutViewModel)
        }
    }
}
