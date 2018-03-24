//
//  GradeCell.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class GradeCell: UITableViewCell {
    
    var nameLabel: UILabel = {
        let nl = UILabel()
        nl.textAlignment = .left
        nl.font = UIFont(name: "AvenirNext-Regular", size: 22)
        return nl
    }()
    
    var gradeLabel: UILabel = {
        let gl = UILabel()
        gl.textAlignment = .right
        gl.font = UIFont(name: "AvenirNext-UltraLight", size: 22)
        return gl
    }()
    
    var weightLabel: UILabel = {
        let wl = UILabel()
        wl.translatesAutoresizingMaskIntoConstraints = false
        wl.textAlignment = .left
        wl.font = UIFont(name: "AvenirNext-Regular", size: 18)
        return wl
    }()
    
    let stackView: UIStackView = {
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
        
        // Constraints.
        self.addSubview(self.stackView)
        NSLayoutConstraint.activate([
                self.stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
                self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
                self.stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10)
            ])
        
        self.addSubview(self.weightLabel)
        NSLayoutConstraint.activate([
                self.weightLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
                self.weightLabel.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 14),
                self.weightLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10)
            ])
    }
    
    public func configureCell(grade: Grade) {
        self.nameLabel.text = grade.name
        self.gradeLabel.text = "\(grade.grade) %"
        self.weightLabel.text = "\(grade.weight)"
    }

}
