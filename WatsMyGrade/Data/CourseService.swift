//
//  CourseService.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-21.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import Foundation
import CoreData

protocol CourseServiceDelegate: class {
    func coursesLoaded()
}

class CourseService {
    
    static var shared = CourseService()
    
    var courses = [Course]()
    
    func getCourses() {
        let fetchRequest: NSFetchRequest<Course> = Course.fetchRequest()
        
        do {
            let courses = try DataController.context.fetch(fetchRequest)
            self.courses = courses
        } catch let err {
            print(err)
        }
    }
    
    func createCourse(code: String, name: String, grade: Double) {
        let course = Course(context: DataController.context)
        course.code = code
        course.name = name
        course.grade = grade
        DataController.saveContext()
        self.courses.append(course)
    }
    
}
