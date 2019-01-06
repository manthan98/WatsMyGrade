//
//  NewTaskViewController.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class NewTaskViewController: AddEditViewController {
    
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
        
        self.navigationItem.title = "New Task"
        
        textFieldThree.inputView = datePicker
        
        textFieldOne.placeholder = "Name"
        textFieldTwo.placeholder = "Priority"
        textFieldThree.placeholder = "Date"
    }
    
    override func submitPressed() {
        super.submitPressed()
        
        if let name = textFieldOne.text, let priority = textFieldTwo.text, let date = textFieldThree.text {
            if (name == "" || priority == "" || date == "") {
                ErrorHandler.sendAlert(title: "Error", message: "Invalid or empty fields.", for: self)
            } else {
                TaskService.shared.createTask(name: name, priority: priority, date: date, course: course)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    // MARK: - Private
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        textFieldThree.text = dateFormatter.string(from: sender.date)
    }
    
    private let course: Course
    
    private lazy var datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        return dp
    }()
    
    private let dateFormatter = DateFormatter()

}
