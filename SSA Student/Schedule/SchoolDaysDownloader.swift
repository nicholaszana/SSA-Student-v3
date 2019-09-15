//
//  ScheduleDownloader.swift
//  SSA Student
//
//  Created by Nick on 9/3/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import Foundation
import Firebase
import CoreData

class SchoolDaysDownloader {
    
    static func checkSchedule(completion: (() -> Void)?) {
        ref.child("scheduleVersion").observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value as? String else {return}
            guard let currentValue = Defaults.get(key: .scheduleVersion) as? String else {return}
            if value != currentValue {
                SchoolDaysDownloader.downloadCycle(completion: completion)
                Defaults.set(value: value, key: .scheduleVersion)
            }
        }
    }
    
    static func downloadSchedules(completion: (() -> Void)?) {
        ref.child("schoolDays").observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value as? [NSDictionary] else {return}

            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            guard let entity = NSEntityDescription.entity(forEntityName: CoreDataStrings.schoolDay.rawValue, in: managedContext) else {return}
            
              SchoolDaysDownloader.deleteAllEntitiesOfType(CoreDataStrings.schoolDay.rawValue)
            
            for dic in value {
                if let date = dic["date"], let cycleDay = dic["cycleDay"] {
                    let schoolDay = NSManagedObject(entity: entity, insertInto: managedContext)
                    schoolDay.setValue(date, forKey: CoreDataStrings.schoolDayDate.rawValue)
                    schoolDay.setValue(cycleDay, forKey: CoreDataStrings.schoolDayCycleDay.rawValue)
                }
                
                do {
                    try managedContext.save()
                    
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                    return
                }
                
            }
            
            guard let hander = completion else {return}
            hander()
        }
    }
    
    static func downloadCycle(completion: (() -> Void)?) {
        
        ref.child("cycle").observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value as? [String: [[String: String]]] else {return}
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            guard let entity = NSEntityDescription.entity(forEntityName: CoreDataStrings.cycleDay.rawValue, in: managedContext) else {return}
            
            guard let periodEntity = NSEntityDescription.entity(forEntityName: CoreDataStrings.cyclePeriod.rawValue, in: managedContext) else {return}
              SchoolDaysDownloader.deleteAllEntitiesOfType(CoreDataStrings.schoolDay.rawValue)
            
            for dayPair in value {
                let dayValue = dayPair.key.replacingOccurrences(of: "day", with: "")
                
                guard let cycleDay = NSManagedObject(entity: entity, insertInto: managedContext) as? CoreDataCycleDay else {return}
                
                for periodDic in dayPair.value {
                    if let block = periodDic["class"],
                        let name = periodDic["name"],
                        let time = periodDic["time"] {
                        guard let period = NSManagedObject(entity: periodEntity, insertInto: managedContext) as? CoreDataCyclePeriod else {return}
                        period.block = block
                        period.name = name
                        period.time = time
                        period.parentCycleDay = cycleDay
                        
                        cycleDay.addToPeriods(period)
                    }
                }
                
                cycleDay.setValue(dayValue, forKey: CoreDataStrings.cycleDayValue.rawValue)
            }
            
            do {
               try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                return
            }
            
            SchoolDaysDownloader.downloadSchedules(completion: completion)
        }
    }
    
    static func deleteAllEntitiesOfType(_ entity : String) {

        let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch
        {
            print ("There was an error clearing entities")
        }
    }
    
}
