//
//  NetworkManager.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2019-01-14.
//  Copyright © 2019 Manthan Shah. All rights reserved.
//

import Foundation

let baseURL = "http://localhost:3005/v1"
let createCourseURL = "\(baseURL)/course/add"
let getCoursesURL = "\(baseURL)/course"
let updateCourseURL = "\(baseURL)/course/update"
let deleteCourseURL = "\(baseURL)/course/delete"

protocol NetworkManagerDelegate: class {
    func coursesLoaded()
}

class NetworkManager {
    
    static let shared = NetworkManager()
    weak var delegate: NetworkManagerDelegate?
    
    func createCourse(_ name: String, credits: Double, code: String, completion: @escaping (_ success: Bool) -> ()) {
        let json: [String:Any] = [
            "name": name,
            "credits": credits,
            "code": code
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            
            guard let url = URL(string: createCourseURL) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                if error == nil {
                    guard let response = response as? HTTPURLResponse else { return }
                    let statusCode = response.statusCode
                    
                    print("URL session task succeeded: HTTP \(statusCode)")
                    
                    completion(statusCode != 200 ? false : true)
                }
            }
            
            task.resume()
            session.finishTasksAndInvalidate()
        } catch let err {
            print(err)
        }
    }
    
    func getCourses() {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let url = URL(string: getCoursesURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else { return }
                let statusCode = response.statusCode
                
                print("URL session task succeeded: HTTP \(statusCode)")
                
                if let data = data {
                    Course.parseJSON(data: data)
                    self.delegate?.coursesLoaded()
                }
            }
        }
        
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    func updateCourse(_ name: String, credits: Double, code: String, networkID: String, grade: Double, completion: @escaping (_ success: Bool) -> ()) {
        let json: [String:Any] = [
            "name": name,
            "credits": credits,
            "code": code,
            "name": name
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            
            guard let url = URL(string: "\(updateCourseURL)/\(networkID)") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                if error == nil {
                    guard let response = response as? HTTPURLResponse else { return }
                    let statusCode = response.statusCode
                    
                    print("URL session task succeeded: HTTP \(statusCode)")
                    
                    completion(statusCode != 200 ? false : true)
                } else {
                    print("URL session task failed: \(error.debugDescription)")
                    completion(false)
                }
            }
            
            task.resume()
            session.finishTasksAndInvalidate()
        } catch let err {
            print(err)
        }
    }
    
    func deleteCourse(networkID: String) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let url = URL(string: "\(deleteCourseURL)/\(networkID)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            guard let response = response as? HTTPURLResponse else { return }
            let statusCode = response.statusCode
            
            print("URL session task succeeded: HTTP \(statusCode)")
        }
        
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
}
