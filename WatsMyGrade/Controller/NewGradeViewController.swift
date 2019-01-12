//
//  NewGradeViewController.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-23.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class NewGradeViewController: AddEditViewController {
    
    init(course: Course) {
        self.course = course
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setup() {
        super.setup()
        
        textFieldOne.placeholder = "Name"
        textFieldTwo.placeholder = "Grade"
        textFieldThree.placeholder = "Weight"
        
        self.navigationItem.title = "New Grade"
    }
    
    override func submitPressed() {
        super.submitPressed()
        
        if let name = textFieldOne.text, let grade = textFieldTwo.text, let weight = textFieldThree.text {
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
    
    // MARK: - Private
    
    private let course: Course

}
