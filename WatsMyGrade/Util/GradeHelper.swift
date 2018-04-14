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
    
    public func getFinalMark(grades: [Grade], course: Course) -> Double {
        var top = 0.0
        var bottom = 0.0
        for i in grades.indices {
            top = top + (grades[i].grade * grades[i].weight)
            bottom = bottom + grades[i].weight
        }
        return (top / bottom)
    }
    
    public func getOverallMark(courses: [Course]) -> Double {
        var average = 0.0
        for i in courses.indices {
            average = average + courses[i].grade
        }
        return (average / Double(courses.count))
    }
    
}
