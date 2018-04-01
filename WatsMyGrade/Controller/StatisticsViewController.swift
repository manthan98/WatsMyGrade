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
    
    let barChart: BarChartView = {
        let view = BarChartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.barChart)
        self.barChart.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.barChart.topAnchor.constraintEqualToSystemSpacingBelow(self.view.safeAreaLayoutGuide.topAnchor, multiplier: 1.0).isActive = true
        self.barChart.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.barChart.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func updateBarChart() {
        
    }

}
