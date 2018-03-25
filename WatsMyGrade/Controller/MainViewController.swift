//
//  MainViewController.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-18.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CourseCell.self, forCellReuseIdentifier: "CourseCell")
        
        CourseService.shared.delegate = self
        CourseService.shared.getCourses()
        
        self.view.addSubview(tableView)
        
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        CourseService.shared.getCourses()
        self.tableView.reloadData()
    }
    
    private func setup() {
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "#79b9e1")
        self.navigationItem.title = "Courses"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.tableView.backgroundColor = UIColor(hexString: "#F0F0F0")
        self.tableView.separatorStyle = .none
    }
    
    @objc private func add() {
        let newCourseViewController = NewCourseViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(newCourseViewController, animated: true)
    }

}

extension MainViewController: CourseServiceDelegate {
    func coursesLoaded() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CourseService.shared.courses.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gradesViewController = GradesViewController(nibName: nil, bundle: nil)
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        gradesViewController.course = CourseService.shared.courses[indexPath.row]
        self.navigationController?.pushViewController(gradesViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as? CourseCell {
            cell.configureCell(course: CourseService.shared.courses[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            CourseService.shared.deleteCourse(index: indexPath.row, course: CourseService.shared.courses[indexPath.row])
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

