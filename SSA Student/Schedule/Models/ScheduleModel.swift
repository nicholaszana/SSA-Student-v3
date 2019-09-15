//
//  ScheduleModel.swift
//  SSA Student
//
//  Created by Nick on 8/18/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import Foundation

//
struct ScheduleModel {
    let classes: [ScheduleBlock: ScheduleClass]
}

//Schedule Model
struct SchedulePeriodViewModel {
    let periodName: String
    let periodTime: String
    let className: String
    let classId: String
    let classType: ClassType
    let moreInfo: String?
}

struct ScheduleViewModel {
    let schoolDay: SchoolDay
    let periodModels: [SchedulePeriodViewModel]
}


//Cycle Model
enum ScheduleBlock {
    case A
    case B
    case C
    case D
    case E
    case F
    case G
    case H
    case other
    
    static func classify(_ string: String) -> ScheduleBlock {
        switch string {
        case "A":
            return .A
        case "B":
            return .B
        case "C":
            return .C
        case "D":
            return .D
        case "E":
            return .E
        case "F":
            return .F
        case "G":
            return .G
        case "H":
            return .H
        default:
            return .other
        }
    }
    
    func toString() -> String {
        switch self {
        case .A:
            return "A"
        case .B:
            return "B"
        case .C:
            return "C"
        case .D:
            return "D"
        case .E:
            return "E"
        case .F:
            return "F"
        case .G:
            return "G"
        case .H:
            return "H"
        default:
            return "other"
        }
    }
    
    func scienceInverse() -> ScheduleBlock? {
        switch self {
            
        case .A:
            return .H
        case .B:
            return .A
        case .C:
            return .B
        case .D:
            return .G
        case .E:
            return .D
        case .F:
            return .E
        case .G:
            return .C
        case .H:
            return .F
        case .other:
            return nil
        }
    }
    
    func getDescriptorString() -> String {
        switch self {
            
        case .D:
            return "Day 1 Period 4"
        case .H:
            return "Day 2 Period 4"
        case .C:
            return "Day 3 Period 4"
        case .E:
            return "Day 4 Period 4"
        case .A:
            return "Day 5 Period 4"
        case .G:
            return "Day 6 Period 4"
        case .F:
            return "Day 7 Period 4"
        case .B:
            return "Day 8 Period 4"
        case .other:
            return ""
            
        }
    }
}

enum CycleDays {
    case day0
    case day1
    case day2
    case day3
    case day4
    case day5
    case day6
    case day7
    case day8
    case day10
    case day11
    case day12
    case day13
    case day14
    case day15
    case day16
    case day17
    case day18
    
    public func toString() -> String {
        switch self {
            
        case .day0:
            return "0"
        case .day1:
            return "1"
        case .day2:
            return "2"
        case .day3:
            return "3"
        case .day4:
            return "4"
        case .day5:
            return "5"
        case .day6:
            return "6"
        case .day7:
            return "7"
        case .day8:
            return "8"
        case .day10:
            return "0"
        case .day11:
            return "1"
        case .day12:
            return "2"
        case .day13:
            return "3"
        case .day14:
            return "4"
        case .day15:
            return "5"
        case .day16:
            return "6"
        case .day17:
            return "7"
        case .day18:
            return "8"
        }
        
        func toNormal() -> CycleDays {
            switch self {
                
            case .day0:
                return .day0
            case .day1:
                return .day1
            case .day2:
                return .day2
            case .day3:
                return .day3
            case .day4:
                return .day4
            case .day5:
                return .day5
            case .day6:
                return .day6
            case .day7:
                return .day7
            case .day8:
                return.day8
            case .day10:
                return .day0
            case .day11:
                return .day1
            case .day12:
                return .day2
            case .day13:
                return .day3
            case .day14:
                return .day4
            case .day15:
                return .day5
            case .day16:
                return .day6
            case .day17:
                return .day7
            case .day18:
                return .day8
            }
        }
    }
    
    static func classify(_ day: String) -> CycleDays? {
        switch day {
        case "0":
            return .day0
        case "1":
            return .day1
        case "2":
            return .day2
        case "3":
            return .day3
        case "4":
            return .day4
        case "5":
            return .day5
        case "6":
            return .day6
        case "7":
            return .day7
        case "8":
            return .day8
        case "10":
            return .day10
        case "11":
            return .day11
        case "12":
            return .day12
        case "13":
            return .day13
        case "14":
            return .day14
        case "15":
            return .day15
        case "16":
            return .day16
        case "17":
            return .day17
        case "18":
            return .day18
        default:
            return nil
        }
    }
}

struct CyclePeriod {
    let block: ScheduleBlock
    let time: String
    let name: String
}

struct CycleDay {
    let cycleDay: CycleDays
    let periods: [CyclePeriod]
}

struct SchoolDay {
    let index: Int
    let cycleDay: CycleDays
    let date: Date
}

