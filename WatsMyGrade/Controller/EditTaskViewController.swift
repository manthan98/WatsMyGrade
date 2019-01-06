//
//  EditTaskViewController.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class EditTaskViewController: AddEditViewController {
    
    init(index: Int, task: Task) {
        self.index = index
        self.task = task
        
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
        
        deleteButton.isHidden = false
        
        textFieldOne.text = task.name
        textFieldTwo.text = task.priority
        textFieldThree.text = task.date
        
        textFieldThree.inputView = datePicker
    }
    
    override func submitPressed() {
        super.submitPressed()
        
        if let name = textFieldOne.text, let priority = textFieldTwo.text, let date = textFieldThree.text {
            if (name == "" || priority == "" || date == "") {
                ErrorHandler.sendAlert(title: "Error", message: "Invalid or empty fields.", for: self)
            } else {
                TaskService.shared.updateTask(name: name, priority: priority, date: date, task: self.task)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func deletePressed() {
        super.deletePressed()
        
        TaskService.shared.deleteTask(index: index, task: task)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        textFieldThree.text = dateFormatter.string(from: sender.date)
    }
    
    private let task: Task
    
    private let index: Int
    
    private lazy var datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        return dp
    }()
    
    private let dateFormatter = DateFormatter()

}
