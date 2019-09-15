//
//  CoreData.swift
//  SSA Student
//
//  Created by Nick on 9/9/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHelper {
    static func clearCoreData(entity:String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let moc = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: entity, in: moc)
        fetchRequest.includesPropertyValues = false
        do {
            if let results = try moc.fetch(fetchRequest) as? [NSManagedObject] {
                for result in results {
                    moc.delete(result)
                }
                
                try moc.save()
            }
        } catch {
            print("failed to clear core data")
        }
    }
}
