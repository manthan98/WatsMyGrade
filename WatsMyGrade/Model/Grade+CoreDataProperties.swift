//
//  Grade+CoreDataProperties.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//
//

import Foundation
import CoreData


extension Grade {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Grade> {
        return NSFetchRequest<Grade>(entityName: "Grade")
    }

    @NSManaged public var grade: Double
    @NSManaged public var name: String?
    @NSManaged public var weight: Double
    @NSManaged public var course: Course?

}
