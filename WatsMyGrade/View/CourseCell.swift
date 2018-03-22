//
//  CourseCell.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-18.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class CourseCell: UITableViewCell {
    
    let codeLabel: UILabel = {
        let cl = UILabel()
        cl.translatesAutoresizingMaskIntoConstraints = false
        cl.textAlignment = .left
        cl.text = "BME 121"
        return cl
    }()
    
    let gradeLabel: UILabel = {
        let gl = UILabel()
        gl.translatesAutoresizingMaskIntoConstraints = false
        gl.textAlignment = .right
        gl.text = "91 %"
        return gl
    }()
    
    let nameLabel: UILabel = {
        let nl = UILabel()
        nl.translatesAutoresizingMaskIntoConstraints = false
        nl.textAlignment = .left
        nl.text = "Digital Computation"
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
        NSLayoutConstraint.activate([
                self.codeLabel.widthAnchor.constraint(equalToConstant: self.codeLabel.intrinsicContentSize.width),
                self.codeLabel.heightAnchor.constraint(equalToConstant: self.codeLabel.intrinsicContentSize.height)
            ])
        
        NSLayoutConstraint.activate([
                self.gradeLabel.widthAnchor.constraint(equalToConstant: self.gradeLabel.intrinsicContentSize.width),
                self.gradeLabel.heightAnchor.constraint(equalToConstant: self.gradeLabel.intrinsicContentSize.height),
            ])
        
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
                self.nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            ])
    }

}
