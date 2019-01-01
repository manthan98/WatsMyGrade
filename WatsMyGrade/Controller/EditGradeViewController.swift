//
//  EditGradeViewController.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class EditGradeViewController: UIViewController {
    
    init(grade: Grade) {
        self.grade = grade
        
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
        self.navigationItem.title = "Edit Grade"
        
        nameField.text = grade.name
        gradeField.text = "\(grade.grade)"
        weightField.text = "\(grade.weight)"
        
        // Views
        self.view.addSubview(stackView)
        self.view.addSubview(submitButton)
        stackView.addArrangedSubview(nameField)
        stackView.addArrangedSubview(gradeField)
        stackView.addArrangedSubview(weightField)
        
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
        
        gradeField.anchor(top: nil,
                          leading: self.view.leadingAnchor,
                          bottom: nil,
                          trailing: self.view.trailingAnchor)
        
        weightField.anchor(top: nil,
                           leading: self.view.leadingAnchor,
                           bottom: nil,
                           trailing: self.view.trailingAnchor)
        
        submitButton.anchor(top: stackView.bottomAnchor,
                            leading: self.view.leadingAnchor,
                            bottom: nil,
                            trailing: self.view.trailingAnchor,
                            padding: .init(top: 15, left: 100, bottom: 0, right: 100))
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
    
    private let grade: Grade
    
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
    
    private let gradeField: UITextField = {
        let tf = UITextField(frame: .zero)
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
        let tf = UITextField(frame: .zero)
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
