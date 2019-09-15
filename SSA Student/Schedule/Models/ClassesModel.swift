//
//  ClassesModel.swift
//  SSA Student
//
//  Created by Nick on 9/8/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import Foundation

enum ScheduleLunch {
    case AB
    case BC
    
    static func classify(_ string: String) -> ScheduleLunch? {
        print(string)
        if string == "AB" {
            return .AB
        } else if string == "BC" {
            return .BC
        } else {
            return nil
        }
    }
    
    func toString() -> String {
        switch self {
        case .AB:
            return "AB"
        case .BC:
            return "BC"
        }
    }
}
//
enum Term {
    case Term1
    case Term2
    case Term3
}
//
enum ClassType {
    case normal
    case science
    case health
    case free
    case lunch
    case other
    
    static func classify(_ classId: String) -> ClassType {
        if classId == "null" {
            return .free
        }
        
        guard classId.count > 1 else {return .other}
        
        let identifier = String(classId[classId.index(classId.startIndex, offsetBy: 0)]) + String(classId[classId.index(classId.startIndex, offsetBy: 1)])
        switch identifier {
        case "AR", "CN", "CS", "DR", "EC", "EN", "FR", "GM", "HI", "LA", "MA", "MU", "PL", "SP":
            return .normal
        case "BI", "CH", "ES", "PS", "PY":
            return .science
        case "HE", "SC":
            return .health
        default:
            return .other
        }
    }
}
//
struct ScheduleClass {
    
    static let free = ScheduleClass(classId: "null", lunch: .AB, name: "Free", type: .free)
    static let lunch = ScheduleClass(classId: "null", lunch: .AB, name: "Lunch", type: .lunch)
    
    let classId: String
    let lunch: ScheduleLunch
    let name: String
    let type: ClassType
}
