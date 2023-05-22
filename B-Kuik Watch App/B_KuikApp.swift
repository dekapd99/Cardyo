//
//  B_KuikApp.swift
//  B-Kuik Watch App
//
//  Created by Deka Primatio on 22/05/23.
//

import SwiftUI

@main
struct B_Kuik_Watch_AppApp: App {
    //MARK: - PROPERTIES
    @StateObject var workoutManager = WorkoutManager()
    
    //MARK: - FIRST SCREEN
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environmentObject(workoutManager)
        }
    }
}
