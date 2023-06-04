//
//  ExtensionActivityType.swift
//  Cardyo WatchKit App
//
//  Created by Deka Primatio on 04/06/23.
//  Copyright © 2023 Apple. All rights reserved.
//

import SwiftUI
import HealthKit

//MARK: - HEALTHKIT ACTIVITY TYPE (EXTENSION)
extension HKWorkoutActivityType: Identifiable {
    public var id: UInt {
        rawValue
    }
    
    //MARK: - WORKOUT TYPES NAME
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
    
    //MARK: - WORKOUT TYPES ICON
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
}//: - HEALTHKIT ACTIVITY TYPE (EXTENSION)

