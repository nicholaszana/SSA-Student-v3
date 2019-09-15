//
//  UserDefaults.swift
//  SSA Student
//
//  Created by Nick on 8/28/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import Foundation

enum UserDefaultsKey: String {
    
    static let entities: [UserDefaultsKey] = [.scheduleLargeTitleToggleSwitch, .userId, .userType, .schoolId, .scheduleVersion, .hasDownloadedSchedule]
    
    case isFirstLaunch = "isFirstLaunch"
    
    case scheduleLargeTitleToggleSwitch = "scheduleLargeTitleToggleSwitch"
    
    case userId = "userId"
    case userType = "userType"
    
    case schoolId = "schoolId"
    
    case scheduleVersion = "ScheduleVersion"
    
    case hasDownloadedSchedule = "hasDownloadedSchedule"
}

enum UserType: String {
    case faculty = "faculty"
    case student = "student"
    case parent = "parent"
    
    static func classify(_ string: String) -> UserType? {
        switch string {
        case UserType.faculty.rawValue:
            return .faculty
        case UserType.student.rawValue:
            return .student
        case UserType.parent.rawValue:
            return .parent
        default:
            return nil
        }
    }
}

class Defaults {
    
    static func set(value: Any?, key: UserDefaultsKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func get(key: UserDefaultsKey) -> Any? {
        return UserDefaults.standard.value(forKey: key.rawValue)
    }
}
 
