//
//  NewCourseViewController.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-18.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class NewCourseViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(codeField)
        self.view.addSubview(nameField)
        self.view.addSubview(creditsField)
        self.view.addSubview(submitButton)
        
        setup()
    }
    
    // MARK: - Private
    
    private func setup() {
        self.view.backgroundColor = .wmg_grey
        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.title = "New Course"
        
        // Views
        self.view.addSubview(stackView)
        self.view.addSubview(submitButton)
        stackView.addArrangedSubview(codeField)
        stackView.addArrangedSubview(nameField)
        stackView.addArrangedSubview(creditsField)
        
        // Constraints
        stackView.anchor(top: self.view.topAnchor,
                              leading: self.view.leadingAnchor,
                              bottom: nil,
                              trailing: self.view.trailingAnchor,
                              padding: .init(top: 200, left: 0, bottom: 0, right: 0))
        
        codeField.anchor(top: nil,
                         leading: self.view.leadingAnchor,
                         bottom: nil,
                         trailing: self.view.trailingAnchor)
        
        nameField.anchor(top: nil,
                         leading: self.view.leadingAnchor,
                         bottom: nil,
                         trailing: self.view.trailingAnchor)
        
        creditsField.anchor(top: nil,
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
    
    private lazy var submitButton: UIButton = {
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

}
