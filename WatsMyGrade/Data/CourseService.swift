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
    weak var delegate: CourseServiceDelegate?
    
    public var courses = [Course]()
    
    public func createCourse(code: String, name: String, credits: Double, grade: Double) {
        let course = Course(context: DataController.context)
        course.code = code
        course.name = name
        course.grade = grade
        course.credits = credits
        DataController.saveContext()
        self.courses.append(course)
    }
    
    public func getCourses() {
        let fetchRequest: NSFetchRequest<Course> = Course.fetchRequest()
        
        do {
            let courses = try DataController.context.fetch(fetchRequest)
            self.courses = courses
            self.delegate?.coursesLoaded()
        } catch let err {
            print(err)
        }
    }
    
    public func updateCourse(code: String, name: String, credits: Double, grade: Double, course: Course) {
        course.code = code
        course.name = name
        course.credits = credits
        course.grade = grade
        
        DataController.saveContext()
        print("COURSE UPDATE SUCCESS")
    }
    
    public func deleteCourse(index: Int, course: Course) {
        DataController.context.delete(course)
        self.courses.remove(at: index)
    }
    
}
