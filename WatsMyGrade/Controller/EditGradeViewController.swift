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
        
        self.submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        self.submitButton.setTitle("Submit", for: .normal)
        self.submitButton.setTitleColor(UIColor.white, for: .normal)
        self.submitButton.layer.cornerRadius = 7.0
        self.submitButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        
        // Add views
        self.view.addSubview(self.stackView)
        self.view.addSubview(self.submitButton)
        self.stackView.addArrangedSubview(self.nameField)
        self.stackView.addArrangedSubview(self.gradeField)
        self.stackView.addArrangedSubview(self.weightField)
        
        // Constraints
        self.stackView.anchor(top: self.view.topAnchor,
                              leading: self.view.leadingAnchor,
                              bottom: nil,
                              trailing: self.view.trailingAnchor,
                              padding: .init(top: 200, left: 0, bottom: 0, right: 0))
        
        self.nameField.anchor(top: nil, leading: self.view.leadingAnchor,
                              bottom: nil, trailing: self.view.trailingAnchor)
        
        self.gradeField.anchor(top: nil, leading: self.view.leadingAnchor,
                               bottom: nil, trailing: self.view.trailingAnchor)
        
        self.weightField.anchor(top: nil, leading: self.view.leadingAnchor,
                                bottom: nil, trailing: self.view.trailingAnchor)
        
        self.submitButton.anchor(top: self.stackView.bottomAnchor,
                                 leading: self.view.leadingAnchor,
                                 bottom: nil,
                                 trailing: self.view.trailingAnchor,
                                 padding: .init(top: 15, left: 100, bottom: 0, right: -100))
    }
    
    @objc private func submit() {
        if let mark = gradeField.text, let name = nameField.text, let weight = weightField.text {
            if (mark == "" || name == "" || weight == "") {
                ErrorHandler.sendAlert(title: "Error", message: "Invalid or empty fields.", for: self)
            } else {
                guard let mark = Double(mark) else { return }
                guard let weight = Double(weight) else { return }
                GradeService.shared.updateGrade(mark: mark, name: name, weight: weight, grade: self.grade)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

}
