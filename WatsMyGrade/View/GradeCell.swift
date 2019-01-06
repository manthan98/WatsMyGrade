//
//  GradeCell.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class GradeCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.layer.cornerRadius = 12.0
        self.layer.masksToBounds = true
        
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
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(forGrade grade: Grade) {
        nameLabel.text = grade.name
        gradeLabel.text = "\(grade.grade) %"
        weightLabel.text = "\(grade.weight)"
    }
    
    func configureCell(forTask task: Task) {
        nameLabel.text = task.name
        gradeLabel.text = task.date
        weightLabel.text = task.priority
    }
    
    // MARK: - Private
    
    private func setup() {
        // Views
        self.addSubview(weightLabel)
        self.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(gradeLabel)
        
        // Constraints
        stackView.anchor(top: self.topAnchor,
                              leading: self.leadingAnchor,
                              bottom: nil,
                              trailing: self.trailingAnchor,
                              padding: .init(top: 14, left: 10, bottom: 0, right: 10))
        
        weightLabel.anchor(top: stackView.bottomAnchor,
                                leading: self.leadingAnchor,
                                bottom: nil,
                                trailing: self.trailingAnchor,
                                padding: .init(top: 14, left: 10, bottom: 0, right: 10))
    }
    
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

}
