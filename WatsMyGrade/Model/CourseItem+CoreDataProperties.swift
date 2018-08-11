//
//  CourseItem+CoreDataProperties.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-08-11.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//
//

import Foundation
import CoreData


extension CourseItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CourseItem> {
        return NSFetchRequest<CourseItem>(entityName: "CourseItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var grade: Double
    @NSManaged public var weight: Double
    @NSManaged public var date: String?
    @NSManaged public var priority: String?
    @NSManaged public var marked: Bool
    @NSManaged public var course: Course?

}
