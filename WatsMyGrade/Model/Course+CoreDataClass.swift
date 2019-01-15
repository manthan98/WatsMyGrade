//
//  Course+CoreDataClass.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Course)
public class Course: NSManagedObject {

}

extension Course {
    static func parseJSON(data: Data) {
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            if let courses = jsonResult as? [[String:Any]] {
                courses.forEach { (course) in
                    guard let name = course["name"] as? String else { return }
                    guard let code = course["code"] as? String else { return }
                    guard let credits = course["credits"] as? Double else { return }
                    guard let networkID = course["_id"] as? String else { return }
                    
                    if let grade = course["grade"] as? Double {
                        CourseService.shared.createCourse(code: code, name: name, credits: credits, grade: grade, id: networkID)
                    } else {
                        CourseService.shared.createCourse(code: code, name: name, credits: credits, grade: 0, id: networkID)
                    }
                }
            }
        } catch let err {
            print(err)
        }
    }
}
