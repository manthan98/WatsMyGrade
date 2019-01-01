//
//  NewGradeViewController.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-23.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class NewGradeViewController: UIViewController {
    
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
        self.view.backgroundColor = .wmg_grey
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.title = "New Grade"
        
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
        
        submitButton.anchor(top: self.stackView.bottomAnchor,
                            leading: self.view.leadingAnchor,
                            bottom: nil,
                            trailing: self.view.trailingAnchor,
                            padding: .init(top: 15, left: 100, bottom: 0, right: 100))
    }
    
    @objc private func submit() {
        if let name = nameField.text, let grade = gradeField.text, let weight = weightField.text {
            if (name == "" || grade == "" || weight == "") {
                ErrorHandler.sendAlert(title: "Error", message: "Invalid or empty fields.", for: self)
            } else {
                guard let grade = Double(grade) else { return }
                guard let weight = Double(weight) else { return }
                GradeService.shared.createGrade(name: name, mark: grade, weight: weight, course: course)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private let course: Course
    
    private let nameField: WMGTextField = {
        let tf = WMGTextField(placeholder: "Name", padding: 5)
        return tf
    }()
    
    private let gradeField: WMGTextField = {
        let tf = WMGTextField(placeholder: "Grade", padding: 5)
        return tf
    }()
    
    private let weightField: WMGTextField = {
        let tf = WMGTextField(placeholder: "Weight", padding: 5)
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

}
