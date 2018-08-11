//
//  MainViewController.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-18.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let overallGradeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overallGradeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.alignment = .center
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CourseCell.self, forCellReuseIdentifier: "CourseCell")
        
        CourseService.shared.delegate = self
        CourseService.shared.getCourses()
        
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        CourseService.shared.getCourses()
        self.tableView.reloadData()
    }
    
    private func setup() {
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "#FFD54F")
        self.navigationItem.title = "Courses"
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        plusButton.accessibilityIdentifier = "newCoursePlusButton"
        self.navigationItem.rightBarButtonItem = plusButton
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        
        self.overallGradeNameLabel.text = "Overall Average"
        self.overallGradeLabel.text = "\(GradeHelper.shared.getOverallMark(courses: CourseService.shared.courses)) %"
        self.containerView.backgroundColor = UIColor(hexString: "#F8F8F8")
        
        // Add views.
        self.stackView.addArrangedSubview(self.overallGradeNameLabel)
        self.stackView.addArrangedSubview(self.overallGradeLabel)
        self.containerView.addSubview(self.stackView)
        self.view.addSubview(self.containerView)
        self.view.addSubview(tableView)
        
        // Constraints.
        self.containerView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.containerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.containerView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        self.stackView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        self.stackView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -15).isActive = true
        
        self.tableView.topAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
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

