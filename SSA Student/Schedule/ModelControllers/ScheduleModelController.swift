//
//  ScheduleModelController.swift
//  SSA Student
//
//  Created by Nick on 8/24/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit
import CoreData

struct ScheduleModelController {
    
    static func getScheduleFrom(_ model: ScheduleModel, schoolDay: SchoolDay, cycleDays: [CycleDays: CycleDay]) -> ScheduleViewModel? {
        let df = DateFormatter()
        df.dateStyle = .long
        
        var periodModels = [SchedulePeriodViewModel]()
        
        guard let cycleDay = cycleDays[schoolDay.cycleDay] else {return nil}
        for period in cycleDay.periods {
            let block = period.block
            
            var scheduleClass: ScheduleClass?
            
            if block == .other {
                scheduleClass = ScheduleClass(classId: "null", lunch: .AB, name: period.name, type: .other)
            } else {
                guard let targetClass = model.classes[block] else {return nil}
                if period.name == "Period 2" || period.name == "Period 5" {
                    guard let scienceBlock = block.scienceInverse() else {return nil}
                    if let inverseClass = model.classes[scienceBlock], inverseClass.type == .science {
                        scheduleClass = inverseClass
                    } else {
                        switch targetClass.type {
                            
                        case .normal:
                            scheduleClass = targetClass
                        case .science:
                            scheduleClass = targetClass
                        case .health:
                            scheduleClass = ScheduleClass.free
                        case .free:
                            scheduleClass = ScheduleClass.free
                        case .lunch:
                            scheduleClass = ScheduleClass.lunch
                        case .other:
                            return nil
                        }
                    }
                    
                                        
                } else if period.name == "Period 4a" {
                    scheduleClass = targetClass.lunch == .AB ? targetClass : ScheduleClass.lunch
                } else if period.name == "Period 4c" {
                    scheduleClass = targetClass.lunch == .BC ? targetClass : ScheduleClass.lunch
                } else {
                    scheduleClass = targetClass
                }
            }
            
            
            guard scheduleClass != nil else {return nil}
            
            let periodViewModel = SchedulePeriodViewModel(periodName: period.name, periodTime: period.time, className: scheduleClass!.name, classId: scheduleClass!.classId, classType: scheduleClass!.type, moreInfo: nil)
            periodModels.append(periodViewModel)
        }
        
        let scheduleModel = ScheduleViewModel(schoolDay: schoolDay, periodModels: periodModels)
        
        return scheduleModel
    }
    
    static func getSchoolDays() -> [SchoolDay]? {
        var objects: [NSManagedObject]?
        var temp: [SchoolDay] = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return nil}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataStrings.schoolDay.rawValue)
        
        do {
            objects = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch school days. \(error), \(error.userInfo)")
            return nil
        }
        
        guard objects != nil else {return nil}
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        var count = 0
        for object in objects! {
            if
                let dateString = object.value(forKeyPath: CoreDataStrings.schoolDayDate.rawValue) as? String,
                let cycleDayInt = object.value(forKeyPath: CoreDataStrings.schoolDayCycleDay.rawValue) as? Int,
                let date = df.date(from: dateString),
                let cycleDay = CycleDays.classify("\(cycleDayInt)") {
                let schoolDay = SchoolDay(index: count, cycleDay: cycleDay, date: date)
                temp.append(schoolDay)
                count += 1
            }
        }
        
        return temp
    }
    
    static func getCycle() -> [CycleDays: CycleDay]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return nil}
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: CoreDataStrings.cycleDay.rawValue)
        
        var cycleDayCoreDataObjects = [CoreDataCycleDay]()
        
        do {
            guard let objects = try managedContext.fetch(fetchRequest) as? [CoreDataCycleDay] else {return nil}
            cycleDayCoreDataObjects = objects
            
        } catch let error as NSError {
            print("Could not fetch cycleDays \(error) \(error.userInfo)")
        }
        
        var dictionary = [CycleDays: CycleDay]()
        
        for cycleDay in cycleDayCoreDataObjects {
            guard let cycleDayString = cycleDay.day else {return nil}
            guard let block = CycleDays.classify(cycleDayString) else {return nil}
            guard let periods = cycleDay.periods?.array as? [CoreDataCyclePeriod] else {return nil}
            var periodsArray = [CyclePeriod]()
            for period in periods {
                guard let blockString = period.block else {return nil}
                guard let time = period.time else {return nil}
                guard let name = period.name else {return nil}
                let periodObject = CyclePeriod(block: ScheduleBlock.classify(blockString), time: time, name: name)
                periodsArray.append(periodObject)
            }
            
            let cycleDayObject = CycleDay(cycleDay: block, periods: periodsArray)            
            dictionary[block] = cycleDayObject
        }
        
        return dictionary
    }
     
    static func getClasses() -> ScheduleModel? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return nil}
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: CoreDataStrings.scheduleClass.rawValue)
        
        var scheduleDayCoreDataObjects = [CoreDataScheduleClass]()
        
        do {
            guard let objects = try managedContext.fetch(fetchRequest) as? [CoreDataScheduleClass] else {return nil}
            scheduleDayCoreDataObjects = objects
            
        } catch let error as NSError {
            print("Could not fetch classes - \(error) \(error.userInfo)")
        }
        
        var dictionary = [ScheduleBlock: ScheduleClass]()
        
        for object in scheduleDayCoreDataObjects {
            if
                let classId = object.classId,
                let lunch = object.lunch,
                let name = object.name,
                let block = object.block,
                let lunchObject = ScheduleLunch.classify(lunch) {
                let classObject = ScheduleClass(classId: classId, lunch: lunchObject, name: name, type: ClassType.classify(classId))
                 
                dictionary[ScheduleBlock.classify(block)] = classObject
            }
        }
        
        for block in [ScheduleBlock.A, ScheduleBlock.B, ScheduleBlock.C, ScheduleBlock.D, ScheduleBlock.E, ScheduleBlock.F, ScheduleBlock.G, ScheduleBlock.H] {
            if dictionary[block] == nil {
                dictionary[block] = ScheduleClass.free
            }
        }
        
        return ScheduleModel(classes: dictionary)
    }

}
