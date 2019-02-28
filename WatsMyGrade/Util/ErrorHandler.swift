//
//  ErrorHandler.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-04-13.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

enum ErrorStrings: String {
    case defaultTitle = "Error"
    case defaultMessage = "Invalid or empty fields."
}

class ErrorHandler {
    
    static func sendAlert(title: String, message: String, for viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}
