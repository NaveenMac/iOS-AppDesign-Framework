//
//  PaddedTextField.swift
//
//
//  Created by Naveen Chauhan on 27/01/21.
//  
//

import UIKit
class PaddedTextField: UITextField {
    let padding = UIEdgeInsets(top: 3, left: 10, bottom: 3, right: 3)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)

    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
