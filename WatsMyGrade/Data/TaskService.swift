//
//  TaskService.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import Foundation
import CoreData

class TaskService {
    
    static var shared = TaskService()
    
    public var tasks = [Task]()
    
    public func createTask(name: String, priority: String, date: String, course: Course) {
        let task = Task(context: DataController.context)
        task.name = name
        task.priority = priority
        task.date = date
        task.course = course
        DataController.saveContext()
        self.tasks.append(task)
    }
    
    public func getTasks(course: Course) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "course == %@", course)
        
        do {
            let tasks = try DataController.context.fetch(fetchRequest)
            self.tasks = tasks
        } catch let err {
            print(err)
        }
    }
    
    public func updateTask(name: String, priority: String, date: String, task: Task) {
        task.name = name
        task.priority = priority
        task.date = date
        
        DataController.saveContext()
        print("UPDATE TASK SUCCESS")
    }
    
    public func deleteTask(index: Int, task: Task) {
        DataController.context.delete(task)
        self.tasks.remove(at: index)
        DataController.saveContext()
    }
    
}
