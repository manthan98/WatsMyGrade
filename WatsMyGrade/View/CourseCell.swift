//
//  CourseCell.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-18.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class CourseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.layer.cornerRadius = 12.0
        self.layer.masksToBounds = true
        
        addDropShadow()
        
        setup()
        
        let deleteLabel2 = UILabel()
        deleteLabel2.text = "delete"
        deleteLabel2.textColor = UIColor.white
        self.insertSubview(deleteLabel2, belowSubview: self.contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(course: Course) {
        self.codeLabel.text = course.code
        self.nameLabel.text = course.name
        self.gradeLabel.text = "\(course.grade) %"
    }
    
    // MARK: - Private
    
    private func setup() {
        // Views
        self.addSubview(nameLabel)
        self.addSubview(stackView)
        stackView.addArrangedSubview(codeLabel)
        stackView.addArrangedSubview(gradeLabel)
        
        // Constraints
        stackView.anchor(top: self.topAnchor,
                         leading: self.leadingAnchor,
                         bottom: nil,
                         trailing: self.trailingAnchor,
                         padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        
        nameLabel.anchor(top: self.stackView.bottomAnchor,
                         leading: self.leadingAnchor,
                         bottom: nil,
                         trailing: self.trailingAnchor,
                         padding: .init(top: 14, left: 10, bottom: 0, right: 10))
    }
    
    private func addDropShadow() {
        self.contentView.layer.cornerRadius = 12.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
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
    
}
