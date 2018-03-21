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
        let cf = UILabel()
        cf.translatesAutoresizingMaskIntoConstraints = false
        return cf
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    private func setup() {
        self.addSubview(self.codeLabel)
        NSLayoutConstraint.activate([
                self.codeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                self.codeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
    }

}
