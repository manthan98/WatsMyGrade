//
//  GradeHelper.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import Foundation

class GradeHelper {
    
    static var shared = GradeHelper()
    
    func getFinalGrade(grades: [Grade], course: Course) -> Double {
        var top = 0.0
        var bottom = 0.0

        grades.forEach { (grade) in
            top = top + (grade.grade * grade.weight)
            bottom = bottom + grade.weight
        }
        
        return top / bottom
    }
    
    func getOverallGrade() -> Double {
        return CourseService.shared.courses.isEmpty ? 0.0 : getOverallGrade(courses: CourseService.shared.courses).rounded(toPlaces: 2)
    }
    
    // MARK: - Private
    
    private func getOverallGrade(courses: [Course]) -> Double {
        var average = 0.0
        courses.forEach({ average = average + $0.grade })
        return average / Double(courses.count)
    }
    
}
