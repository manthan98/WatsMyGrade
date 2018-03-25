//
//  GradeService.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-23.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import Foundation
import CoreData

protocol GradeServiceDelegate: class {
    func gradesLoaded()
}

class GradeService {
    
    static var shared = GradeService()
    weak var delegate: GradeServiceDelegate?
    
    public var grades = [Grade]()
    
    public func createGrade(name: String, mark: Double, weight: Double, course: Course) {
        let grade = Grade(context: DataController.context)
        grade.name = name
        grade.grade = mark
        grade.weight = weight
        grade.course = course
        DataController.saveContext()
        self.grades.append(grade)
    }
    
    public func getGrades(course: Course) {
        let fetchRequest: NSFetchRequest<Grade> = Grade.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "course == %@", course)
        
        do {
            let grades = try DataController.context.fetch(fetchRequest)
            self.grades = grades
            self.delegate?.gradesLoaded()
            print("SUCCESS")
        } catch let err {
            print(err)
        }
    }
    
    public func updateGrade(mark: Double, name: String, weight: Double, grade: Grade) {
        grade.setValue(mark, forKey: "grade")
        grade.setValue(name, forKey: "name")
        grade.setValue(weight, forKey: "weight")
        
        DataController.saveContext()
        
        print("UPDATE GRADE SUCCESS")
    }
    
    public func deleteGrade(index: Int, grade: Grade) {
        DataController.context.delete(grade)
        self.grades.remove(at: index)
        DataController.saveContext()
    }
    
}
