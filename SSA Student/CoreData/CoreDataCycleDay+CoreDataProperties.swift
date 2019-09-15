//
//  CoreDataCycleDay+CoreDataProperties.swift
//  SSA Student
//
//  Created by Nick on 9/7/19.
//  Copyright © 2019 Nick. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreDataCycleDay {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataCycleDay> {
        return NSFetchRequest<CoreDataCycleDay>(entityName: "CoreDataCycleDay")
    }

    @NSManaged public var day: String?
    @NSManaged public var periods: NSOrderedSet?

}

// MARK: Generated accessors for periods
extension CoreDataCycleDay {

    @objc(insertObject:inPeriodsAtIndex:)
    @NSManaged public func insertIntoPeriods(_ value: CoreDataCyclePeriod, at idx: Int)

    @objc(removeObjectFromPeriodsAtIndex:)
    @NSManaged public func removeFromPeriods(at idx: Int)

    @objc(insertPeriods:atIndexes:)
    @NSManaged public func insertIntoPeriods(_ values: [CoreDataCyclePeriod], at indexes: NSIndexSet)

    @objc(removePeriodsAtIndexes:)
    @NSManaged public func removeFromPeriods(at indexes: NSIndexSet)

    @objc(replaceObjectInPeriodsAtIndex:withObject:)
    @NSManaged public func replacePeriods(at idx: Int, with value: CoreDataCyclePeriod)

    @objc(replacePeriodsAtIndexes:withPeriods:)
    @NSManaged public func replacePeriods(at indexes: NSIndexSet, with values: [CoreDataCyclePeriod])

    @objc(addPeriodsObject:)
    @NSManaged public func addToPeriods(_ value: CoreDataCyclePeriod)

    @objc(removePeriodsObject:)
    @NSManaged public func removeFromPeriods(_ value: CoreDataCyclePeriod)

    @objc(addPeriods:)
    @NSManaged public func addToPeriods(_ values: NSOrderedSet)

    @objc(removePeriods:)
    @NSManaged public func removeFromPeriods(_ values: NSOrderedSet)

}
