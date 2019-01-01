//
//  EditTaskViewController.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class EditTaskViewController: UIViewController {
    
    init(task: Task) {
        self.task = task
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    // MARK: - Private
    
    private func setup() {
        self.view.backgroundColor = .wmg_grey
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.title = "New Task"
        
        nameField.text = task.name
        priorityField.text = task.priority
        dateField.text = task.date
        
        dateField.inputView = datePicker
        
        // Add views
        self.view.addSubview(stackView)
        self.view.addSubview(submitButton)
        stackView.addArrangedSubview(nameField)
        stackView.addArrangedSubview(priorityField)
        stackView.addArrangedSubview(dateField)
        
        // Constraints
        stackView.anchor(top: self.view.topAnchor,
                         leading: self.view.leadingAnchor,
                         bottom: nil,
                         trailing: self.view.trailingAnchor,
                         padding: .init(top: 200, left: 0, bottom: 0, right: 0))
        
        nameField.anchor(top: nil,
                         leading: self.view.leadingAnchor,
                         bottom: nil,
                         trailing: self.view.trailingAnchor)
        
        priorityField.anchor(top: nil,
                             leading: self.view.leadingAnchor,
                             bottom: nil,
                             trailing: self.view.trailingAnchor)
        
        dateField.anchor(top: nil,
                         leading: self.view.leadingAnchor,
                         bottom: nil,
                         trailing: self.view.trailingAnchor)
        
        submitButton.anchor(top: self.stackView.bottomAnchor,
                            leading: self.view.leadingAnchor,
                            bottom: nil,
                            trailing: self.view.trailingAnchor,
                            padding: .init(top: 15, left: 100, bottom: 0, right: 100))
    }
    
    @objc private func submit() {
        if let name = nameField.text, let priority = priorityField.text, let date = dateField.text {
            if (name == "" || priority == "" || date == "") {
                ErrorHandler.sendAlert(title: "Error", message: "Invalid or empty fields.", for: self)
            } else {
                TaskService.shared.updateTask(name: name, priority: priority, date: date, task: self.task)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateField.text = dateFormatter.string(from: sender.date)
    }
    
    private let task: Task
    
    private let nameField: WMGTextField = {
        let tf = WMGTextField(placeholder: "Name", padding: 5)
        return tf
    }()
    
    private let priorityField: WMGTextField = {
        let tf = WMGTextField(placeholder: "Priority", padding: 5)
        return tf
    }()
    
    private let dateField: WMGTextField = {
        let tf = WMGTextField(placeholder: "Date", padding: 5)
        return tf
    }()
    
    private lazy var submitButton: WMGButton = {
        let button = WMGButton(title: "Submit")
        button.addTarget(self, action: #selector(submit), for: .touchUpInside)
        return button
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.alignment = .center
        sv.spacing = 15
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        return dp
    }()
    
    private let dateFormatter = DateFormatter()

}
