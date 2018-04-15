//
//  LineChart.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-04-14.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit
import Charts

class LineChart: UIView {

    // Line graph properties.
    let lineChartView = LineChartView()
    var lineDataEntry: [ChartDataEntry] = []
    
    // Chart data.
    var courses = [String]()
    var grades = [Double]()
    
    var delegate: GetChartData! {
        didSet {
            populateData()
            lineChartSetup()
        }
    }
    
    func populateData() {
        courses = delegate.courses
        grades = delegate.grades
    }
    
    func lineChartSetup() {
        // Line chart configuration.
        self.backgroundColor = UIColor.white
        self.addSubview(lineChartView)
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        lineChartView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        lineChartView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lineChartView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        // Line chart animation.
        lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInSine)
        
        // Line chart population.
        setLineChart(dataPoints: courses, values: grades)
    }
    
    func setLineChart(dataPoints: [String], values: [Double]) {
        // No data setup.
        lineChartView.noDataTextColor = UIColor.black
        lineChartView.noDataText = "No data available."
        lineChartView.backgroundColor = UIColor.white
        
        // Data point setup and colour configuration.
        for i in dataPoints.indices {
            let dataPoint = ChartDataEntry(x: Double(i), y: values[i])
            lineDataEntry.append(dataPoint)
        }
        
        let chartDataSet = LineChartDataSet(values: lineDataEntry, label: "Grade")
        let chartData = LineChartData()
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(true)
        chartDataSet.colors = [UIColor(hexString: "#FFD54F")]
        chartDataSet.setCircleColor(UIColor(hexString: "#FFD54F"))
        chartDataSet.circleHoleColor = UIColor(hexString: "#FFD54F")
        chartDataSet.circleRadius = 4.0
        
        // Gradient fill.
        let gradientColors = [UIColor(hexString: "#FFD54F").cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.0] // Position.
        guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) else { print("Gradient error."); return }
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        chartDataSet.drawFilledEnabled = true
        
        // Axes setup.
        let formatter: ChartFormatter = ChartFormatter()
        formatter.setValues(values: dataPoints)
        let xAxis: XAxis = XAxis()
        xAxis.valueFormatter = formatter
        lineChartView.xAxis.enabled = false
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.valueFormatter = xAxis.valueFormatter
        lineChartView.chartDescription?.enabled = false
        lineChartView.legend.enabled = true
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawLabelsEnabled = true
        lineChartView.leftAxis.enabled = false
        
        lineChartView.data = chartData
    }

}
