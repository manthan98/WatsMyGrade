//
//  CourseCell.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-18.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class CourseCell: UITableViewCell {
    
    var codeLabel: UILabel = {
        let cl = UILabel()
        cl.textAlignment = .left
        cl.font = UIFont(name: "AvenirNext-Regular", size: 22)
        return cl
    }()
    
    var gradeLabel: UILabel = {
        let gl = UILabel()
        gl.textAlignment = .right
        gl.font = UIFont(name: "AvenirNext-UltraLight", size: 22)
        return gl
    }()
    
    var nameLabel: UILabel = {
        let nl = UILabel()
        nl.translatesAutoresizingMaskIntoConstraints = false
        nl.textAlignment = .left
        nl.font = UIFont(name: "AvenirNext-Regular", size: 18)
        return nl
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    private func setup() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.addArrangedSubview(self.codeLabel)
        stackView.addArrangedSubview(self.gradeLabel)
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
                stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
                stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10)
            ])
        
        self.addSubview(self.nameLabel)
        NSLayoutConstraint.activate([
                self.nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
                self.nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
                self.nameLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 14)
            ])
    }
    
    public func configureCell(course: Course) {
        self.codeLabel.text = course.code
        self.nameLabel.text = course.name
        self.gradeLabel.text = "\(course.grade)"
    }

}
