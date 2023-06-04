//
//  BKuikApp.swift
//  B-Kuik WatchKit App
//
//  Created by Deka Primatio on 23/05/23.
//  Copyright © 2023 Apple. All rights reserved.
//

import SwiftUI

@main
struct BKuikApp: App {
    @StateObject private var workoutManager = WorkoutViewModel()

    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                StartView()
            }
            .fullScreenCover(isPresented: $workoutManager.showingSummaryView) {
                BreathView()
                    .navigationBarBackButtonHidden(true)
            }
            .environmentObject(workoutManager)
        }
    }
}
