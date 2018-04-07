//
//  StatisticsViewController.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-25.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit
import Charts

class StatisticsViewController: UIViewController {
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let overallGradeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let overallGradeLabel: UILabel = {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setup()
    }
    
    private func setup() {
        self.view.backgroundColor = UIColor.white
        self.containerView.backgroundColor = UIColor(hexString: "#F8F8F8")
        
        self.overallGradeNameLabel.text = "Overall Average"
        self.overallGradeLabel.text = "\(GradeHelper.shared.getOverallMark(courses: CourseService.shared.courses)) %"
        
        self.stackView.addArrangedSubview(self.overallGradeNameLabel)
        self.stackView.addArrangedSubview(self.overallGradeLabel)
        self.containerView.addSubview(self.stackView)
        self.view.addSubview(self.containerView)
        
        // Constraints.
        self.containerView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.containerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.containerView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        self.stackView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.stackView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
    }

}
