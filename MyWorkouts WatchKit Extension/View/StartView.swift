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
    @EnvironmentObject var workoutManager: WorkoutViewModel
    var workoutTypes: [HKWorkoutActivityType] = [ .badminton, .basketball, .bowling, .cycling, .golf, .highIntensityIntervalTraining, .jumpRope, .martialArts, .running, .soccer, .walking, .yoga]
    
    //MARK: - BODY
    var body: some View {
        
        //MARK: - MAIN WRAPPER (VSTACK)
        VStack(alignment: .leading) {
            Text("Choose Your Exercise:")
                .font(.system(size: 12))
                .fontWeight(.semibold)
                .padding()
            
            //MARK: - WORKOUT LIST WITH EACH NAVIGATIONLINK
            List(workoutTypes) { workoutType in
                NavigationLink(destination: SessionPagingView(),
                               tag: workoutType,
                               selection: $workoutManager.selectedWorkout) {
                    
                    //MARK: - WORKOUT CAROUSEL COMPONENT (HSTACK)
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
                    }//: - WORKOUT CAROUSEL COMPONENT (HSTACK)
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                }//EACH NAVIGATION LINK
                
            }//: - WORKOUT LIST WITH EACH NAVIGATIONLINK
            .listStyle(.carousel)
            .onAppear {
                workoutManager.requestAuthorization()
                
                //MARK: - REQUEST PERMISSION (USER NOTIFICATION)
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
                    if granted {
                        //Create a user notification content
                        let content = UNMutableNotificationContent()
                        content.title = "Cardyo"
                        content.body = "Start your fitness journey today and witness the transformative benefits that regular exercise can bring to your life."
                        
                        //Create a trigger for daily notifications at 7 A.M.
                        var dateComponents = DateComponents()
                        dateComponents.hour = 07
                        dateComponents.minute = 00
                        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                        
                        //Create a notification request
                        let request = UNNotificationRequest(identifier: "exercise", content: content, trigger: trigger)
                        
                        //Schedule the notification
                        UNUserNotificationCenter.current().add(request)
                    } else {
                        print("User notification permission not granted: \(error?.localizedDescription ?? "unknown error")")
                    }//: - IF ELSE STATEMENT
                }//: - REQUEST PERMISSION (USER NOTIFICATION)
            }//: - USER NOTIFICATION (onAppear)
            
        }//: - MAIN WRAPPER (VSTACK)
        
    }//: - BODY
}

//MARK: - PREVIEW
struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView().environmentObject(WorkoutViewModel())
    }
}
