//
//  GradeService.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-23.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import Foundation
import CoreData

class GradeService {
    
    static var shared = GradeService()
    
    var grades = [Grade]()
    
    func getGrades(course: Course) {
        let fetchRequest: NSFetchRequest<Grade> = Grade.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "course == %@", course)
        
        do {
            let grades = try DataController.context.fetch(fetchRequest)
            self.grades = grades
            print("SUCCESS")
        } catch let err {
            print(err)
        }
    }
    
    func createGrade(name: String, mark: Double, weight: Double, course: Course) {
        let grade = Grade(context: DataController.context)
        grade.name = name
        grade.grade = mark
        grade.weight = weight
        grade.course = course
        DataController.saveContext()
        self.grades.append(grade)
    }
    
}
