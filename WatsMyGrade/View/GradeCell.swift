//
//  GradeCell.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class GradeCell: UITableViewCell {
    
    private let nameLabel: UILabel = {
        let nl = UILabel()
        nl.textAlignment = .left
        nl.font = UIFont(name: "AvenirNext-Regular", size: 22)
        return nl
    }()
    
    private let gradeLabel: UILabel = {
        let gl = UILabel()
        gl.textAlignment = .right
        gl.font = UIFont(name: "AvenirNext-UltraLight", size: 22)
        return gl
    }()
    
    private let weightLabel: UILabel = {
        let wl = UILabel()
        wl.translatesAutoresizingMaskIntoConstraints = false
        wl.textAlignment = .left
        wl.font = UIFont(name: "AvenirNext-Regular", size: 18)
        return wl
    }()
    
    private let stackView: UIStackView = {
        let s1 = UIStackView()
        s1.axis = .horizontal
        s1.distribution = .equalCentering
        s1.alignment = .center
        s1.spacing = 10
        s1.translatesAutoresizingMaskIntoConstraints = false
        return s1
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    private func setup() {
        self.stackView.addArrangedSubview(self.nameLabel)
        self.stackView.addArrangedSubview(self.gradeLabel)
        self.addSubview(self.stackView)
        self.addSubview(self.weightLabel)
        
        // Constraints.
        self.stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 14).isActive = true
        self.stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        
        self.weightLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        self.weightLabel.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 14).isActive = true
        self.weightLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
    }
    
    func configureCell(grade: Grade) {
        self.nameLabel.text = grade.name
        self.gradeLabel.text = "\(grade.grade) %"
        self.weightLabel.text = "\(grade.weight)"
    }
    
    func configureCell(task: Task) {
        self.nameLabel.text = task.name
        self.gradeLabel.text = task.date
        self.weightLabel.text = task.priority
    }

}
