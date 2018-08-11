//
//  NewCourseViewController.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-18.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class NewCourseViewController: UIViewController, UITextFieldDelegate {
    
    private let codeField: UITextField = {
        let textFrame = CGRect(x: 300, y: 300, width: 200, height: 30)
        let tf = UITextField(frame: textFrame)
        tf.borderStyle = .roundedRect
        tf.textColor = UIColor.black
        tf.font = UIFont(name: "AvenirNext", size: 17)
        tf.placeholder = "Code"
        tf.autocorrectionType = .yes
        tf.keyboardType = .default
        tf.clearButtonMode = .whileEditing
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
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
    
    private let creditsField: UITextField = {
        let textFrame = CGRect(x: 300, y: 300, width: 200, height: 30)
        let tf = UITextField(frame: textFrame)
        tf.borderStyle = .roundedRect
        tf.textColor = UIColor.black
        tf.font = UIFont(name: "AvenirNext", size: 17)
        tf.placeholder = "Credits"
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.codeField.delegate = self
        self.view.addSubview(codeField)
        self.nameField.delegate = self
        self.view.addSubview(nameField)
        self.creditsField.delegate = self
        self.view.addSubview(creditsField)
        self.view.addSubview(submitButton)
        
        setup()
    }
    
    private func setup() {
        self.view.backgroundColor = UIColor(hexString: "#F0F0F0")
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.title = "New Course"
        
        // Add views.
        self.view.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.codeField)
        self.stackView.addArrangedSubview(self.nameField)
        self.stackView.addArrangedSubview(self.creditsField)
        
        // Constraints.
        self.stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200).isActive = true
        self.stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        self.codeField.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.codeField.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        self.nameField.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nameField.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        self.creditsField.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.creditsField.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
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
        if let code = codeField.text, let name = nameField.text, let credits = creditsField.text {
            if (code == "" || name == "" || credits == "") {
                ErrorHandler.sendAlert(title: "Error", message: "Invalid or empty fields.", for: self)
            } else {
                CourseService.shared.createCourse(code: code, name: name, credits: Double(credits)!, grade: 0)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

}
