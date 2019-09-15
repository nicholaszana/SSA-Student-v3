//
//  CoreDataStrings.swift
//  SSA Student
//
//  Created by Nick on 9/7/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import Foundation

enum CoreDataStrings: String {
    
    static let entities: [CoreDataStrings] = [.schoolDay, .cycleDay, .cyclePeriod, .scheduleClass]
    
    case schoolDay = "CoreDataSchoolDay"
    case schoolDayDate = "date"
    case schoolDayCycleDay = "cycleDay"
    
    case cycleDay = "CoreDataCycleDay"
    case cycleDayValue = "day"
    case cycleDayPeriods = "periods"
    
    case cyclePeriod = "CoreDataCyclePeriod"
    
    
    case scheduleClass = "CoreDataScheduleClass"
}
