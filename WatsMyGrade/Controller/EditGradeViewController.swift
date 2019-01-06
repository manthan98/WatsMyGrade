//
//  EditGradeViewController.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class EditGradeViewController: AddEditViewController {
    
    init(index: Int, grade: Grade) {
        self.index = index
        self.grade = grade
        
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
        
        self.navigationItem.title = "Edit Grade"
        
        deleteButton.isHidden = false
        
        textFieldOne.placeholder = "Name"
        textFieldTwo.placeholder = "Grade"
        textFieldThree.placeholder = "Weight"
        
        textFieldOne.text = grade.name
        textFieldTwo.text = "\(grade.grade)"
        textFieldThree.text = "\(grade.weight)"
    }
    
    override func submitPressed() {
        super.submitPressed()
        
        if let name = textFieldOne.text, let mark = textFieldTwo.text, let weight = textFieldThree.text {
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
    
    override func deletePressed() {
        super.deletePressed()
        
        GradeService.shared.deleteGrade(index: index, grade: grade)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private
    
    private let grade: Grade
    
    private let index: Int
    
}
