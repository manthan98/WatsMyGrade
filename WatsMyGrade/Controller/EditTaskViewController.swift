//
//  EditTaskViewController.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class EditTaskViewController: UIViewController {
    
    var task = Task()
    
    let nameField: UITextField = {
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
    
    let priorityField: UITextField = {
        let textFrame = CGRect(x: 300, y: 300, width: 200, height: 30)
        let tf = UITextField(frame: textFrame)
        tf.borderStyle = .roundedRect
        tf.textColor = UIColor.black
        tf.font = UIFont(name: "AvenirNext", size: 17)
        tf.placeholder = "Grade"
        tf.autocorrectionType = .yes
        tf.keyboardType = .default
        tf.clearButtonMode = .whileEditing
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let dateField: UITextField = {
        let textFrame = CGRect(x: 300, y: 300, width: 200, height: 30)
        let tf = UITextField(frame: textFrame)
        tf.borderStyle = .roundedRect
        tf.textColor = UIColor.black
        tf.font = UIFont(name: "AvenirNext", size: 17)
        tf.placeholder = "Weight"
        tf.autocorrectionType = .yes
        tf.keyboardType = .default
        tf.clearButtonMode = .whileEditing
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Button", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.alignment = .center
        sv.spacing = 15
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        self.view.backgroundColor = UIColor.init(hexString: "#F0F0F0")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.title = "New Task"
        
        self.nameField.text = self.task.name
        self.priorityField.text = self.task.priority
        self.dateField.text = self.task.date
        
        self.view.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.nameField)
        self.stackView.addArrangedSubview(self.priorityField)
        self.stackView.addArrangedSubview(self.dateField)
        
        self.datePicker.datePickerMode = .date
        self.dateField.inputView = datePicker
        self.datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        // Constraints.
        self.stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        self.stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        self.nameField.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nameField.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        self.priorityField.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.priorityField.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        self.dateField.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.dateField.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        self.view.addSubview(self.submitButton)
        self.submitButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 100).isActive = true
        self.submitButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -100).isActive = true
        self.submitButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 15.0).isActive = true
        self.submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        self.submitButton.setTitle("Submit", for: .normal)
        self.submitButton.setTitleColor(UIColor.white, for: .normal)
        self.submitButton.layer.cornerRadius = 7.0
        self.submitButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
    }
    
    @objc private func submit() {
        if let name = nameField.text, let priority = priorityField.text, let date = dateField.text {
            TaskService.shared.updateTask(name: name, priority: priority, date: date, task: self.task)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        self.dateFormatter.dateStyle = .medium
        self.dateFormatter.timeStyle = .none
        self.dateField.text = dateFormatter.string(from: sender.date)
    }

}
