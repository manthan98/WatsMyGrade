//
//  WMGTextField.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2019-01-01.
//  Copyright © 2019 Manthan Shah. All rights reserved.
//

import UIKit

class WMGTextField: UITextField {
    
    private let padding: CGFloat

    init(placeholder: String, padding: CGFloat) {
        self.padding = padding
        
        super.init(frame: .zero)
        
        self.borderStyle = .roundedRect
        self.textColor = .black
        self.font = UIFont(name: "AvenirNext", size: 17)
        self.placeholder = placeholder
        self.autocorrectionType = .yes
        self.keyboardType = .default
        self.clearButtonMode = .whileEditing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Padding for text inside the textfield
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
}
