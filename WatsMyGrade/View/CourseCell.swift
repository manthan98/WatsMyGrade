//
//  CourseCell.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-18.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class CourseCell: UITableViewCell {
    
    private let codeLabel: UILabel = {
        let cl = UILabel()
        cl.textAlignment = .left
        cl.font = UIFont(name: "AvenirNext-Regular", size: 22)
        return cl
    }()
    
    private let gradeLabel: UILabel = {
        let gl = UILabel()
        gl.textAlignment = .right
        gl.font = UIFont(name: "AvenirNext-UltraLight", size: 22)
        return gl
    }()
    
    private let nameLabel: UILabel = {
        let nl = UILabel()
        nl.translatesAutoresizingMaskIntoConstraints = false
        nl.textAlignment = .left
        nl.font = UIFont(name: "AvenirNext-Regular", size: 18)
        return nl
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .equalCentering
        sv.alignment = .center
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    private func setup() {
        // Add views.
        stackView.addArrangedSubview(self.codeLabel)
        stackView.addArrangedSubview(self.gradeLabel)
        self.addSubview(stackView)
        self.addSubview(self.nameLabel)
        
        // Constraints.
        self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        self.stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        
        self.nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        self.nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        self.nameLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 14).isActive = true
    }
    
    func configureCell(course: Course) {
        self.codeLabel.text = course.code
        self.nameLabel.text = course.name
        self.gradeLabel.text = "\(course.grade) %"
    }

}
