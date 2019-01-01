//
//  NewTaskViewController.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController {
    
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
    }
    
    // MARK: - Private
    
    private func setup() {
        self.view.backgroundColor = UIColor.init(hexString: "#F0F0F0")
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.title = "New Task"
        
        dateField.inputView = datePicker
        
        // Add views
        self.view.addSubview(stackView)
        self.view.addSubview(submitButton)
        stackView.addArrangedSubview(nameField)
        stackView.addArrangedSubview(priorityField)
        stackView.addArrangedSubview(dateField)
        
        // Constraints
        self.stackView.anchor(top: self.view.topAnchor,
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
                TaskService.shared.createTask(name: name, priority: priority, date: date, course: course)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateField.text = dateFormatter.string(from: sender.date)
    }
    
    private let course: Course
    
    private let nameField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.borderStyle = .roundedRect
        tf.textColor = UIColor.black
        tf.font = UIFont(name: "AvenirNext", size: 17)
        tf.placeholder = "Name"
        tf.autocorrectionType = .yes
        tf.keyboardType = .default
        tf.clearButtonMode = .whileEditing
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let priorityField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.borderStyle = .roundedRect
        tf.textColor = UIColor.black
        tf.font = UIFont(name: "AvenirNext", size: 17)
        tf.placeholder = "Priority"
        tf.autocorrectionType = .yes
        tf.keyboardType = .default
        tf.clearButtonMode = .whileEditing
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let dateField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.borderStyle = .roundedRect
        tf.textColor = UIColor.black
        tf.font = UIFont(name: "AvenirNext", size: 17)
        tf.placeholder = "Date"
        tf.autocorrectionType = .yes
        tf.keyboardType = .default
        tf.clearButtonMode = .whileEditing
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.addTarget(self, action: #selector(submit), for: .touchUpInside)
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 7.0
        button.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
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
