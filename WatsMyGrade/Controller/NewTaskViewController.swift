//
//  NewTaskViewController.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController {
    
    var course = Course()
    
    private let nameField: UITextField = {
        let textFrame = CGRect(x: 300, y: 300, width: 200, height: 30)
        let tf = UITextField(frame: textFrame)
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
        let textFrame = CGRect(x: 300, y: 300, width: 200, height: 30)
        let tf = UITextField(frame: textFrame)
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
        let textFrame = CGRect(x: 300, y: 300, width: 200, height: 30)
        let tf = UITextField(frame: textFrame)
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
        button.setTitle("Button", for: .normal)
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
    
    private let datePicker = UIDatePicker()
    private let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        self.view.backgroundColor = UIColor.init(hexString: "#F0F0F0")
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.title = "New Task"
        
        self.datePicker.datePickerMode = .date
        self.dateField.inputView = datePicker
        self.datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        self.submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        self.submitButton.setTitle("Submit", for: .normal)
        self.submitButton.setTitleColor(UIColor.white, for: .normal)
        self.submitButton.layer.cornerRadius = 7.0
        self.submitButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        
        // Add views
        self.view.addSubview(self.stackView)
        self.view.addSubview(self.submitButton)
        self.stackView.addArrangedSubview(self.nameField)
        self.stackView.addArrangedSubview(self.priorityField)
        self.stackView.addArrangedSubview(self.dateField)
        
        // Constraints
        self.stackView.anchor(top: self.view.topAnchor,
                              leading: self.view.leadingAnchor,
                              bottom: nil,
                              trailing: self.view.trailingAnchor,
                              padding: .init(top: 200, left: 0, bottom: 0, right: 0))
        
        self.nameField.anchor(top: nil, leading: self.view.leadingAnchor,
                              bottom: nil, trailing: self.view.trailingAnchor)
        
        self.priorityField.anchor(top: nil, leading: self.view.leadingAnchor,
                               bottom: nil, trailing: self.view.trailingAnchor)
        
        self.dateField.anchor(top: nil, leading: self.view.leadingAnchor,
                                bottom: nil, trailing: self.view.trailingAnchor)
        
        self.submitButton.anchor(top: self.stackView.bottomAnchor,
                                 leading: self.view.leadingAnchor,
                                 bottom: nil,
                                 trailing: self.view.trailingAnchor,
                                 padding: .init(top: 15, left: 100, bottom: 0, right: -100))
    }
    
    @objc private func submit() {
        if let name = nameField.text, let priority = priorityField.text, let date = dateField.text {
            if (name == "" || priority == "" || date == "") {
                ErrorHandler.sendAlert(title: "Error", message: "Invalid or empty fields.", for: self)
            } else {
                TaskService.shared.createTask(name: name, priority: priority, date: date, course: self.course)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        self.dateFormatter.dateStyle = .medium
        self.dateFormatter.timeStyle = .none
        self.dateField.text = dateFormatter.string(from: sender.date)
    }

}
