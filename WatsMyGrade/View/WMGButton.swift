//
//  WMGButton.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2019-01-01.
//  Copyright © 2019 Manthan Shah. All rights reserved.
//

import UIKit

class WMGButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor.black
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.cornerRadius = 7.0
        self.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
