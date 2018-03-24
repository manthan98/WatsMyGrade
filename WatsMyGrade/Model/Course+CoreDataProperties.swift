//
//  Course+CoreDataProperties.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-23.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//
//

import Foundation
import CoreData


extension Course {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Course> {
        return NSFetchRequest<Course>(entityName: "Course")
    }

    @NSManaged public var code: String?
    @NSManaged public var credits: Double
    @NSManaged public var grade: Double
    @NSManaged public var name: String?
    @NSManaged public var grades: NSSet?

}

// MARK: Generated accessors for grades
extension Course {

    @objc(addGradesObject:)
    @NSManaged public func addToGrades(_ value: Grade)

    @objc(removeGradesObject:)
    @NSManaged public func removeFromGrades(_ value: Grade)

    @objc(addGrades:)
    @NSManaged public func addToGrades(_ values: NSSet)

    @objc(removeGrades:)
    @NSManaged public func removeFromGrades(_ values: NSSet)

}
