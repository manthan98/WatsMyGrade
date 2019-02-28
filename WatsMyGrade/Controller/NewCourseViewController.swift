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
        
        setup()
        setupLayout()
    }
    
    // MARK: - Private
    
    private func setup() {
        self.view.backgroundColor = .wmg_grey
        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.title = "New Course"
    }
    
    private func setupLayout() {
        // Views
        self.view.addSubview(codeField)
        self.view.addSubview(nameField)
        self.view.addSubview(creditsField)
        self.view.addSubview(submitButton)
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
                ErrorHandler.sendAlert(title: ErrorStrings.defaultTitle.rawValue, message: ErrorStrings.defaultMessage.rawValue, for: self)
            } else {
                guard let credits = Double(credits) else { return }
                CourseService.shared.createCourse(code: code, name: name, credits: credits, grade: 0)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private let codeField: WMGTextField = {
        let tf = WMGTextField(placeholder: "Code", padding: 5)
        return tf
    }()
    
    private let nameField: WMGTextField = {
        let tf = WMGTextField(placeholder: "Name", padding: 5)
        return tf
    }()
    
    private let creditsField: WMGTextField = {
        let tf = WMGTextField(placeholder: "Credits", padding: 5)
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
