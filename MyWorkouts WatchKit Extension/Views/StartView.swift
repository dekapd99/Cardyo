//
//  StartView.swift
//  B-Kuik WatchKit App
//
//  Created by Deka Primatio on 23/05/23.
//  Copyright © 2023 Apple. All rights reserved.
//

import SwiftUI
import HealthKit
import UserNotifications

struct StartView: View {
    //MARK: - PROPERTIES
    @EnvironmentObject var workoutManager: WorkoutManager
    var workoutTypes: [HKWorkoutActivityType] = [ .badminton, .basketball, .bowling, .cycling, .golf, .highIntensityIntervalTraining, .jumpRope, .martialArts, .running, .soccer, .walking, .yoga]
    
    //MARK: - BODY
    var body: some View {
        VStack(alignment: .leading) {
            Text("Choose Your Exercise:")
                .font(.system(size: 12))
                .fontWeight(.semibold)
                .padding()
            
            List(workoutTypes) { workoutType in
                NavigationLink(destination: SessionPagingView(),
                               tag: workoutType,
                               selection: $workoutManager.selectedWorkout) {
                    
                    HStack {
                        Circle()
                            .foregroundColor(Color("Red"))
                            .frame(width: 35, height: 35)
                            .overlay(
                                Image(systemName: workoutType.iconName)
                                    .foregroundColor(Color("White"))
                            )
                        
                        Text(workoutType.name)
                            .foregroundColor(Color("White"))
                            .padding(.leading, 5)
                        
                        Spacer()
                        
                        Circle()
                            .foregroundColor(Color("Red"))
                            .frame(width: 15, height: 15)
                            .overlay(
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color("White"))
                                    .font(.system(size: 12))
                            )
                    }
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                }
            }
            .listStyle(.carousel)
            .onAppear {
                workoutManager.requestAuthorization()
                
                // Request permission for user notifications
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
                    if granted {
                        // Create a user notification content
                        let content = UNMutableNotificationContent()
                        content.title = "Cardyo"
                        content.body = "Start your fitness journey today and witness the transformative benefits that regular exercise can bring to your life. Take the first step towards a stronger body, a sharper mind, and a more vibrant you."
                        
                        // Create a trigger for daily notifications at 10 pm
                        var dateComponents = DateComponents()
                        dateComponents.hour = 07
                        dateComponents.minute = 00
                        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                        
                        // Create a notification request
                        let request =    UNNotificationRequest(identifier: "exercise", content: content, trigger: trigger)
                        
                        // Schedule the notification
                        UNUserNotificationCenter.current().add(request)
                    } else {
                        print("User notification permission not granted: \(error?.localizedDescription ?? "unknown error")")
                    }
                }
            }
        }
    }//: - BODY
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView().environmentObject(WorkoutManager())
    }
}

extension HKWorkoutActivityType: Identifiable {
    public var id: UInt {
        rawValue
    }
    
    var name: String {
        switch self {
        case .running:
            return "Running"
        case .cycling:
            return "Cycling"
        case .walking:
            return "Walking"
        case .bowling:
            return "Bowling"
        case .badminton:
            return "Badminton"
        case .soccer:
            return "Soccer"
        case .basketball:
            return "Basketball"
        case .golf:
            return "Golf"
        case .highIntensityIntervalTraining:
            return "Gym"
        case .jumpRope:
            return "Jumping Rope"
        case .martialArts:
            return "MMA"
        case .yoga:
            return "Yoga"
        default:
            return ""
        }
    }
    
    var iconName: String {
        switch self {
        case .running:
            return "figure.run"
        case .cycling:
            return "bicycle"
        case .walking:
            return "figure.walk"
        case .bowling:
            return "figure.bowling"
        case .badminton:
            return "figure.badminton"
        case .soccer:
            return "soccerball.inverse"
        case .basketball:
            return "basketball.fill"
        case .golf:
            return "figure.badminton"
        case .highIntensityIntervalTraining:
            return "dumbbell"
        case .jumpRope:
            return "figure.jumprope"
        case .martialArts:
            return "figure.martial.arts"
        case .yoga:
            return "figure.yoga"
        default:
            return ""
        }
    }
}
