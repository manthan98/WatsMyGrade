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
        // Add views
        self.addSubview(self.nameLabel)
        self.addSubview(self.stackView)
        stackView.addArrangedSubview(self.codeLabel)
        stackView.addArrangedSubview(self.gradeLabel)
        
        // Constraints
        self.stackView.anchor(top: self.topAnchor,
                              leading: self.leadingAnchor,
                              bottom: nil,
                              trailing: self.trailingAnchor,
                              padding: .init(top: 10, left: 10, bottom: 0, right: -10))
        
        self.nameLabel.anchor(top: self.stackView.bottomAnchor,
                              leading: self.leadingAnchor,
                              bottom: nil,
                              trailing: self.trailingAnchor,
                              padding: .init(top: 14, left: 10, bottom: 0, right: -10))
    }
    
    func configureCell(course: Course) {
        self.codeLabel.text = course.code
        self.nameLabel.text = course.name
        self.gradeLabel.text = "\(course.grade) %"
    }

}
