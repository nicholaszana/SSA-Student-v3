//
//  ScheduleDownloadModelController.swift
//  SSA Student
//
//  Created by Nick on 9/8/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import Foundation
import Firebase
import CoreData

class ScheduleDownloadModelController {
    static func downloadSchedule(_ handler: @escaping ([String]) -> Void) {
        
        if globalUser.userId == "NULL" {
            return
        }
        db.collection(FirestoreCollection.students.rawValue).document(globalUser.userId).getDocument { (snapshot, err) in
            if let err = err {
                print(err)
                return
            }
            
            guard let data = snapshot?.data() else {return}
            guard let classIds = data[FirestoreField.classes.rawValue] as? [String] else {return}
            
            handler(classIds)
            
        }
        
    }
    
    static func downloadClass(_ classId: String, handler: @escaping ([String: Any]) -> Void) {
        db.collection(FirestoreCollection.classes.rawValue).document(classId).getDocument { (snapshot, err) in
            if let err = err {
                print(err)
                return
            }
            
            guard let data = snapshot?.data() else {return}
            handler(data)
        }
    }
    
    static func saveClasses(_ classes: [(ScheduleBlock, ScheduleClass)]) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: CoreDataStrings.scheduleClass.rawValue, in: managedContext) else {return}
        
        SchoolDaysDownloader.deleteAllEntitiesOfType(CoreDataStrings.scheduleClass.rawValue)

        for tuple in classes {
            let classObject = tuple.1
            guard let scheduleDay = NSManagedObject(entity: entity, insertInto: managedContext) as? CoreDataScheduleClass else {return}
            scheduleDay.name = classObject.name
            scheduleDay.classId = classObject.classId
            scheduleDay.lunch = classObject.lunch.toString()
            scheduleDay.block = tuple.0.toString()
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save classes. \(error), \(error.userInfo)")
        }
    }
}
