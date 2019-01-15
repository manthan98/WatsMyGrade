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
    
    private(set) var courses = [Course]()
    
    func createCourse(code: String, name: String, credits: Double, grade: Double, id: String?) {
        let course = Course(context: DataController.context)
        course.code = code
        course.name = name
        course.grade = grade
        course.credits = credits
        course.networkID = id ?? ""
        DataController.saveContext()
        self.courses.append(course)
    }
    
    func getCourses() {
        let fetchRequest: NSFetchRequest<Course> = Course.fetchRequest()
        
        do {
            let courses = try DataController.context.fetch(fetchRequest)
            self.courses = courses
            self.delegate?.coursesLoaded()
        } catch let err {
            print(err)
        }
    }
    
    func updateCourse(code: String, name: String, credits: Double, grade: Double, course: Course) {
        course.code = code
        course.name = name
        course.credits = credits
        course.grade = grade
        
        DataController.saveContext()
        print("COURSE UPDATE SUCCESS")
    }
    
    func deleteCourse(index: Int, course: Course) {
        DataController.context.delete(course)
        self.courses.remove(at: index)
        DataController.saveContext()
    }
    
    func clearCourses() {
        do {
            let coursesFetchRequest = NSFetchRequest<Course>(entityName: "Course")
            let courses = try DataController.context.fetch(coursesFetchRequest)
            courses.forEach({ DataController.context.delete($0) })
            DataController.saveContext()
        } catch let err {
            print(err)
        }
    }
    
}
