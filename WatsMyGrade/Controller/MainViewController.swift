//
//  MainViewController.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-18.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
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
        self.overallGradeLabel.text = "\(GradeHelper.shared.getOverallMark(courses: CourseService.shared.courses).rounded(toPlaces: 2)) %"
    }
    
    // MARK: - Private
    
    private func setup() {
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.barTintColor = .wmg_yellow
        self.navigationItem.title = "Courses"
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        plusButton.accessibilityIdentifier = "newCoursePlusButton"
        self.navigationItem.rightBarButtonItem = plusButton
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        
        overallGradeNameLabel.text = "Overall Average"
        overallGradeLabel.text = "\(GradeHelper.shared.getOverallMark(courses: CourseService.shared.courses)) %"
        
        // Views
        stackView.addArrangedSubview(overallGradeNameLabel)
        stackView.addArrangedSubview(overallGradeLabel)
        containerView.addSubview(stackView)
        self.view.addSubview(containerView)
        self.view.addSubview(tableView)
        
        // Constraints
        containerView.anchor(top: self.view.topAnchor,
                                  leading: self.view.leadingAnchor,
                                  bottom: nil,
                                  trailing: self.view.trailingAnchor)
        
        stackView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                              leading: containerView.leadingAnchor,
                              bottom: containerView.bottomAnchor,
                              trailing: containerView.trailingAnchor,
                              padding: .init(top: 15, left: 0, bottom: 15, right: 0))
        
        tableView.anchor(top: containerView.bottomAnchor,
                              leading: self.view.leadingAnchor,
                              bottom: self.view.bottomAnchor,
                              trailing: self.view.trailingAnchor)
    }
    
    @objc private func add() {
        let newCourseViewController = NewCourseViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(newCourseViewController, animated: true)
    }
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .wmg_grey
        tv.separatorStyle = .singleLine
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .wmg_lightGrey
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

}

extension MainViewController: CourseServiceDelegate {
    func coursesLoaded() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
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

