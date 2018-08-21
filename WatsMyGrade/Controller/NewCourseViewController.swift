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
        
        self.submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        self.submitButton.setTitle("Submit", for: .normal)
        self.submitButton.setTitleColor(UIColor.white, for: .normal)
        self.submitButton.layer.cornerRadius = 7.0
        self.submitButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        
        // Add views
        self.view.addSubview(self.stackView)
        self.view.addSubview(self.submitButton)
        self.stackView.addArrangedSubview(self.codeField)
        self.stackView.addArrangedSubview(self.nameField)
        self.stackView.addArrangedSubview(self.creditsField)
        
        // Constraints
        self.stackView.anchor(top: self.view.topAnchor,
                              leading: self.view.leadingAnchor,
                              bottom: nil,
                              trailing: self.view.trailingAnchor,
                              padding: .init(top: 200, left: 0, bottom: 0, right: 0))
        
        self.codeField.anchor(top: nil, leading: self.view.leadingAnchor,
                              bottom: nil, trailing: self.view.trailingAnchor)
        
        self.nameField.anchor(top: nil, leading: self.view.leadingAnchor,
                              bottom: nil, trailing: self.view.trailingAnchor)
        
        self.creditsField.anchor(top: nil, leading: self.view.leadingAnchor,
                              bottom: nil, trailing: self.view.trailingAnchor)
        
        self.submitButton.anchor(top: self.stackView.bottomAnchor,
                                 leading: self.view.leadingAnchor,
                                 bottom: nil,
                                 trailing: self.view.trailingAnchor,
                                 padding: .init(top: 15, left: 100, bottom: 0, right: -100))
    }
    
    @objc private func submit() {
        if let code = codeField.text, let name = nameField.text, let credits = creditsField.text {
            if (code == "" || name == "" || credits == "") {
                ErrorHandler.sendAlert(title: "Error", message: "Invalid or empty fields.", for: self)
            } else {
                guard let credits = Double(credits) else { return }
                CourseService.shared.createCourse(code: code, name: name, credits: credits, grade: 0)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

}
