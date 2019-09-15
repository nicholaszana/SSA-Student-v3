//
//  CoreDataCyclePeriod+CoreDataProperties.swift
//  SSA Student
//
//  Created by Nick on 9/7/19.
//  Copyright © 2019 Nick. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreDataCyclePeriod {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataCyclePeriod> {
        return NSFetchRequest<CoreDataCyclePeriod>(entityName: "CoreDataCyclePeriod")
    }

    @NSManaged public var block: String?
    @NSManaged public var name: String?
    @NSManaged public var time: String?
    @NSManaged public var parentCycleDay: CoreDataCycleDay?

}
