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
    
    var courses = [Course]()
    
    func createCourse(code: String, name: String, credits: Double, grade: Double) {
        let course = Course(context: DataController.context)
        course.code = code
        course.name = name
        course.grade = grade
        course.credits = credits
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
        let fetchRequest: NSFetchRequest<Course> = Course.fetchRequest()
        
        guard let code = course.code else { return }
        let coursePredicate = NSPredicate(format: "code == %@", code)
        
        let creditsPredicate = NSPredicate(format: "credits == %@", course.credits)
        let gradePredicate = NSPredicate(format: "grade == %@", course.grade)
        
        guard let name = course.name else { return }
        let namePredicate = NSPredicate(format: "name == %@", name)
        
        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [coursePredicate, creditsPredicate, gradePredicate, namePredicate])
        fetchRequest.predicate = andPredicate
        
        do {
            let course = try DataController.context.fetch(fetchRequest)
            let courseToUpdate = course[0]
            courseToUpdate.setValue(code, forKey: "code")
            courseToUpdate.setValue(name, forKey: "name")
            courseToUpdate.setValue(credits, forKey: "credits")
            courseToUpdate.setValue(grade, forKey: "grade")
            
            do {
                try DataController.context.save()
                print("SUCCESS!!!!")
            } catch let err {
                print(err)
            }
        } catch let err {
            print(err)
        }
    }
    
}
