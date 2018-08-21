//
//  GradesViewController.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-21.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class GradesViewController: UIViewController {
    
    var course = Course()
    
    let upperContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var courseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var gradeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.alignment = .center
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let segmentedControl: UISegmentedControl = {
        let items = ["Grades", "Tasks"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        sc.tintColor = UIColor(hexString: "#787878")
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(GradeCell.self, forCellReuseIdentifier: "GradeCell")
        
        GradeService.shared.delegate = self
        GradeService.shared.getGrades(course: self.course)
        
        TaskService.shared.getTasks(course: self.course)
        
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        GradeService.shared.getGrades(course: self.course)
        TaskService.shared.getTasks(course: self.course)
    }
    
    private func setup() {
        self.view.backgroundColor = UIColor(hexString: "#F8F8F8")
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.title = course.code
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        plusButton.accessibilityIdentifier = "newGradeOrTaskPlusButton"
        self.navigationItem.rightBarButtonItem = plusButton
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        
        self.courseLabel.text = self.course.name
        self.gradeLabel.text = "\(self.course.grade) %"
        
        self.view.addSubview(self.upperContainerView)
        self.upperContainerView.addSubview(self.stackView)
        self.upperContainerView.backgroundColor = UIColor(hexString: "#F8F8F8")
        
        self.stackView.addArrangedSubview(self.courseLabel)
        self.stackView.addArrangedSubview(self.gradeLabel)
        self.stackView.addArrangedSubview(self.segmentedControl)
        
        self.view.addSubview(self.tableView)
        self.tableView.backgroundColor = UIColor(hexString: "#F0F0F0")
        self.tableView.separatorStyle = .none
        
        self.segmentedControl.addTarget(self, action: #selector(segmentSwap(_:)), for: .valueChanged)
        
        // Constraints
        self.upperContainerView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor)
        
        self.stackView.anchor(top: self.upperContainerView.topAnchor,
                              leading: self.upperContainerView.leadingAnchor,
                              bottom: self.upperContainerView.bottomAnchor,
                              trailing: self.upperContainerView.trailingAnchor,
                              padding: .init(top: 15, left: 0, bottom: -15, right: 0))
        
        self.segmentedControl.anchor(top: nil,
                                     leading: self.view.leadingAnchor,
                                     bottom: nil,
                                     trailing: self.view.trailingAnchor,
                                     padding: .init(top: 0, left: 10, bottom: 0, right: -10))
        
        self.tableView.anchor(top: self.upperContainerView.bottomAnchor,
                              leading: self.view.leadingAnchor,
                              bottom: self.view.bottomAnchor,
                              trailing: self.view.trailingAnchor)
    }
    
    private func getCourseGrade() {
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            let grade = Double(GradeHelper.shared.getFinalMark(grades: GradeService.shared.grades, course: self.course)).rounded(toPlaces: 2)
            self.gradeLabel.text = "\(grade) %"
            CourseService.shared.updateCourse(code: self.course.code!, name: self.course.name!, credits: self.course.credits, grade: grade, course: self.course)
        case 1:
            fallthrough
        default:
            break
        }
    }
    
    @objc private func add(_ sender: UIBarButtonItem) {
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            let newGradeViewController = NewGradeViewController(nibName: nil, bundle: nil)
            newGradeViewController.course = self.course
            self.navigationController?.pushViewController(newGradeViewController, animated: true)
        case 1:
            let newTaskViewController = NewTaskViewController(nibName: nil, bundle: nil)
            newTaskViewController.course = self.course
            self.navigationController?.pushViewController(newTaskViewController, animated: true)
        default:
            break
        }
    }
    
    @objc private func segmentSwap(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }

}

extension GradesViewController: GradeServiceDelegate {
    func gradesLoaded() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            if (!self.tableView.visibleCells.isEmpty) {
                self.getCourseGrade()
            }
        }
    }
}

extension GradesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            return GradeService.shared.grades.count
        case 1:
            return TaskService.shared.tasks.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            let editGradeViewController = EditGradeViewController(nibName: nil, bundle: nil)
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            editGradeViewController.grade = GradeService.shared.grades[indexPath.row]
            self.navigationController?.pushViewController(editGradeViewController, animated: true)
        case 1:
            let editTaskViewController = EditTaskViewController(nibName: nil, bundle: nil)
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            editTaskViewController.task = TaskService.shared.tasks[indexPath.row]
            self.navigationController?.pushViewController(editTaskViewController, animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GradeCell", for: indexPath) as? GradeCell {
            switch (segmentedControl.selectedSegmentIndex) {
            case 0:
                cell.configureCell(grade: GradeService.shared.grades[indexPath.row])
            case 1:
                cell.configureCell(task: TaskService.shared.tasks[indexPath.row])
            default:
                break
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            switch (segmentedControl.selectedSegmentIndex) {
            case 0:
                GradeService.shared.deleteGrade(index: indexPath.row, grade: GradeService.shared.grades[indexPath.row])
                self.getCourseGrade()
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            case 1:
                TaskService.shared.deleteTask(index: indexPath.row, task: TaskService.shared.tasks[indexPath.row])
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            default:
                break
            }
        }
    }
}
