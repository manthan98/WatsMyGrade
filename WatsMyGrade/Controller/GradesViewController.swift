//
//  GradesViewController.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-21.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class GradesViewController: UIViewController {
    
    init(course: Course) {
        self.course = course
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupNavigation()
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let course = course {
            GradeService.shared.getGrades(course: course)
            TaskService.shared.getTasks(course: course)
        }
    }
    
    // MARK: - Private
    
    private func setup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(GradeCell.self, forCellReuseIdentifier: "GradeCell")
        
        GradeService.shared.delegate = self
        
        if let course = course {
            self.navigationItem.title = course.code
            courseLabel.text = course.name
            gradeLabel.text = "\(course.grade) %"
            
            GradeService.shared.getGrades(course: course)
            TaskService.shared.getTasks(course: course)
        }
    }
    
    private func setupNavigation() {
        self.view.backgroundColor = .wmg_lightGrey
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        plusButton.accessibilityIdentifier = "newGradeOrTaskPlusButton"
        self.navigationItem.rightBarButtonItem = plusButton
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
    }
    
    private func setupLayout() {
        // Views
        self.view.addSubview(upperContainerView)
        upperContainerView.addSubview(stackView)
        
        stackView.addArrangedSubview(courseLabel)
        stackView.addArrangedSubview(gradeLabel)
        stackView.addArrangedSubview(segmentedControl)
        
        self.view.addSubview(tableView)
        
        self.view.addSubview(deleteButton)
        
        // Constraints
        upperContainerView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                                  leading: self.view.leadingAnchor,
                                  bottom: nil,
                                  trailing: self.view.trailingAnchor)
        
        stackView.anchor(top: upperContainerView.topAnchor,
                         leading: upperContainerView.leadingAnchor,
                         bottom: upperContainerView.bottomAnchor,
                         trailing: upperContainerView.trailingAnchor,
                         padding: .init(top: 15, left: 0, bottom: 15, right: 0))
        
        segmentedControl.anchor(top: nil,
                                leading: self.view.leadingAnchor,
                                bottom: nil,
                                trailing: self.view.trailingAnchor,
                                padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        
        deleteButton.anchor(top: nil,
                            leading: self.view.leadingAnchor,
                            bottom: self.view.bottomAnchor,
                            trailing: self.view.trailingAnchor,
                            padding: .init(top: 0, left: 100, bottom: 15, right: 100))
        
        tableView.anchor(top: upperContainerView.bottomAnchor,
                         leading: self.view.leadingAnchor,
                         bottom: deleteButton.topAnchor,
                         trailing: self.view.trailingAnchor,
                         padding: .init(top: 0, left: 0, bottom: 15, right: 0))
    }
    
    private func getCourseGrade() {
        if let course = course {
            switch (segmentedControl.selectedSegmentIndex) {
            case 0:
                let grade = Double(GradeHelper.shared.getFinalGrade(grades: GradeService.shared.grades, course: course)).rounded(toPlaces: 2)
                self.gradeLabel.text = "\(grade) %"
                CourseService.shared.updateCourse(code: course.code ?? "", name: course.name ?? "", credits: course.credits, grade: grade, course: course)
            case 1:
                fallthrough
            default:
                break
            }
        }
    }
    
    @objc
    private func add(_ sender: UIBarButtonItem) {
        if let course = course {
            switch (segmentedControl.selectedSegmentIndex) {
            case 0:
                let newGradeViewController = NewGradeViewController(course: course)
                self.navigationController?.pushViewController(newGradeViewController, animated: true)
            case 1:
                let newTaskViewController = NewTaskViewController(course: course)
                self.navigationController?.pushViewController(newTaskViewController, animated: true)
            default:
                break
            }
        }
    }
    
    @objc
    private func segmentSwap(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
    
    @objc
    private func deleteCourse() {
        NotificationCenter.default.post(name: NSNotification.Name.init("deleteCourse"), object: nil, userInfo: ["course": course!])
        self.navigationController?.popViewController(animated: true)
    }
    
    private var course: Course?
    
    private let upperContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .wmg_lightGrey
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var courseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var gradeLabel: UILabel = {
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
    
    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["Grades", "Tasks"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        sc.tintColor = .wmg_darkGrey
        sc.addTarget(self, action: #selector(segmentSwap(_:)), for: .valueChanged)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .wmg_grey
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private lazy var deleteButton: WMGButton = {
        let button = WMGButton(title: "Delete Course")
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(deleteCourse), for: .touchUpInside)
        return button
    }()

}

extension GradesViewController: GradeServiceDelegate {
    func gradesLoaded() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            
            if let isEmpty = self?.tableView.visibleCells.isEmpty {
                if !isEmpty {
                    self?.getCourseGrade()
                }
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
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let editGradeViewController = EditGradeViewController(grade: GradeService.shared.grades[indexPath.row])
            self.navigationController?.pushViewController(editGradeViewController, animated: true)
        case 1:
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let editTaskViewController = EditTaskViewController(task: TaskService.shared.tasks[indexPath.row])
            self.navigationController?.pushViewController(editTaskViewController, animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GradeCell", for: indexPath) as? GradeCell {
            switch (segmentedControl.selectedSegmentIndex) {
            case 0:
                cell.configureCell(forGrade: GradeService.shared.grades[indexPath.row])
            case 1:
                cell.configureCell(forTask: TaskService.shared.tasks[indexPath.row])
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
