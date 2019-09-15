//
//  CoreDataSchoolDay+CoreDataProperties.swift
//  SSA Student
//
//  Created by Nick on 9/7/19.
//  Copyright © 2019 Nick. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreDataSchoolDay {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataSchoolDay> {
        return NSFetchRequest<CoreDataSchoolDay>(entityName: "CoreDataSchoolDay")
    }

    @NSManaged public var cycleDay: Int16
    @NSManaged public var date: String?

}
