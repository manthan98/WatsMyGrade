//
//  GradesViewController.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-21.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class GradesViewController: UIViewController {
    
    let upperContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var courseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var gradeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.alignment = .center
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let segmentedControl: UISegmentedControl = {
        let items = ["Grades", "Tasks"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.courseLabel.text = "Digital Computation"
        self.gradeLabel.text = "91.0 %"
        
        setup()
    }
    
    private func setup() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.view.addSubview(self.upperContainerView)
        self.upperContainerView.addSubview(self.stackView)
        self.upperContainerView.backgroundColor = UIColor(hexString: "#F8F8F8")
        
        self.stackView.addArrangedSubview(self.courseLabel)
        self.stackView.addArrangedSubview(self.gradeLabel)
        self.stackView.addArrangedSubview(self.segmentedControl)
        
        self.view.addSubview(self.tableView)
        self.tableView.backgroundColor = UIColor(hexString: "#F0F0F0")
        self.tableView.separatorStyle = .none
        
        // Constraints.
        self.upperContainerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.upperContainerView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.upperContainerView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        self.stackView.leftAnchor.constraint(equalTo: self.upperContainerView.leftAnchor).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.upperContainerView.topAnchor, constant: 15).isActive = true
        self.stackView.rightAnchor.constraint(equalTo: self.upperContainerView.rightAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.upperContainerView.bottomAnchor, constant: -15).isActive = true

        self.segmentedControl.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        self.segmentedControl.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        
        self.tableView.topAnchor.constraint(equalTo: self.upperContainerView.bottomAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }

}
