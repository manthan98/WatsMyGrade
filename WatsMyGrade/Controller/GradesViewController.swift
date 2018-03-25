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
        sc.tintColor = UIColor(hexString: "#79b9e1")
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
        
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        GradeService.shared.getGrades(course: self.course)
    }
    
    private func setup() {
        self.view.backgroundColor = UIColor(hexString: "#F8F8F8")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.title = course.code
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
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
        
        // Constraints.
        self.upperContainerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.upperContainerView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.upperContainerView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        self.stackView.leftAnchor.constraint(equalTo: self.upperContainerView.leftAnchor).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.upperContainerView.topAnchor, constant: 15).isActive = true
        self.stackView.rightAnchor.constraint(equalTo: self.upperContainerView.rightAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.upperContainerView.bottomAnchor, constant: -15).isActive = true

        self.segmentedControl.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        self.segmentedControl.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        
        self.tableView.topAnchor.constraint(equalTo: self.upperContainerView.bottomAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
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
        let editGradeViewController = EditGradeViewController(nibName: nil, bundle: nil)
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        editGradeViewController.grade = GradeService.shared.grades[indexPath.row]
        self.navigationController?.pushViewController(editGradeViewController, animated: true)
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
}
