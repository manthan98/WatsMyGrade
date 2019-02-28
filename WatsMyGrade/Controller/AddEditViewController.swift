//
//  AddEditViewController.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2019-01-05.
//  Copyright © 2019 Manthan Shah. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupLayout()
    }
    
    func setup() {
        self.view.backgroundColor = .wmg_grey
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    @objc func submitPressed() {
        // Override
    }
    
    @objc func deletePressed() {
        // Override
    }
    
    // MARK: - UI Elements
    
    let textFieldOne: WMGTextField = {
        let tf = WMGTextField(placeholder: "One", padding: 5)
        return tf
    }()
    
    let textFieldTwo: WMGTextField = {
        let tf = WMGTextField(placeholder: "Two", padding: 5)
        return tf
    }()
    
    let textFieldThree: WMGTextField = {
        let tf = WMGTextField(placeholder: "Three", padding: 5)
        return tf
    }()
    
    lazy var submitButton: WMGButton = {
        let button = WMGButton(title: "Submit")
        button.addTarget(self, action: #selector(submitPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var deleteButton: WMGButton = {
        let button = WMGButton(title: "Delete")
        button.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        button.backgroundColor = .red
        button.isHidden = true
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
    
    // MARK: - Private
    
    private func setupLayout() {
        // Views
        self.view.addSubview(stackView)
        self.view.addSubview(submitButton)
        self.view.addSubview(deleteButton)
        stackView.addArrangedSubview(textFieldOne)
        stackView.addArrangedSubview(textFieldTwo)
        stackView.addArrangedSubview(textFieldThree)
        
        // Constraints
        stackView.anchor(top: self.view.topAnchor,
                         leading: self.view.leadingAnchor,
                         bottom: nil,
                         trailing: self.view.trailingAnchor,
                         padding: .init(top: 200, left: 0, bottom: 0, right: 0))
        
        textFieldOne.anchor(top: nil,
                            leading: self.view.leadingAnchor,
                            bottom: nil,
                            trailing: self.view.trailingAnchor)
        
        textFieldTwo.anchor(top: nil,
                            leading: self.view.leadingAnchor,
                            bottom: nil,
                            trailing: self.view.trailingAnchor)
        
        textFieldThree.anchor(top: nil,
                              leading: self.view.leadingAnchor,
                              bottom: nil,
                              trailing: self.view.trailingAnchor)
        
        submitButton.anchor(top: self.stackView.bottomAnchor,
                            leading: self.view.leadingAnchor,
                            bottom: nil,
                            trailing: self.view.trailingAnchor,
                            padding: .init(top: 15, left: 100, bottom: 0, right: 100))
        
        deleteButton.anchor(top: submitButton.bottomAnchor,
                            leading: self.view.leadingAnchor,
                            bottom: nil,
                            trailing: self.view.trailingAnchor,
                            padding: .init(top: 15, left: 100, bottom: 0, right: 100))
    }

}
