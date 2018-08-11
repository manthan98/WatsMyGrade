//
//  EditGradeViewController.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class EditGradeViewController: UIViewController {
    
    var grade = Grade()
    
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
    
    private let gradeField: UITextField = {
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
    
    private let weightField: UITextField = {
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

        setup()
    }
    
    private func setup() {
        self.view.backgroundColor = UIColor.init(hexString: "#F0F0F0")
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.title = "Edit Grade"
        
        self.nameField.text = self.grade.name
        self.gradeField.text = "\(self.grade.grade)"
        self.weightField.text = "\(self.grade.weight)"
        
        // Add views.
        self.view.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.nameField)
        self.stackView.addArrangedSubview(self.gradeField)
        self.stackView.addArrangedSubview(self.weightField)
        
        // Constraints.
        self.stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200).isActive = true
        self.stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        self.nameField.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nameField.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        self.gradeField.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.gradeField.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        self.weightField.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.weightField.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
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
        if let mark = gradeField.text, let name = nameField.text, let weight = weightField.text {
            if (mark == "" || name == "" || weight == "") {
                ErrorHandler.sendAlert(title: "Error", message: "Invalid or empty fields.", for: self)
            } else {
                GradeService.shared.updateGrade(mark: Double(mark)!, name: name, weight: Double(weight)!, grade: self.grade)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

}
