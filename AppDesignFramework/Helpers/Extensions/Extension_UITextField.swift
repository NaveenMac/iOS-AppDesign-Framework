//
//  Extension_UITextField.swift
//  FileManager
//
//  Created by Naveen Chauhan on 26/11/21.
//

import UIKit
import MaterialComponents

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
        func setRightPaddingPoints(_ amount:CGFloat) {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    
    static func getFloatingTextField(tag:Int, style:TextFieldStyle,callback:(()->Void)? = nil)->MDCBaseTextField{
        let textfield = MDCFilledTextField()
       
        if let title = style.title {
            textfield.label.text = title.text
        
        }
        
        if let helperText = style.hint {
            textfield.leadingAssistiveLabel.text = helperText
            textfield.setLeadingAssistiveLabelColor(UIColor.TextField.normalText, for: .normal)
            textfield.setLeadingAssistiveLabelColor(UIColor.TextField.normalText, for: .editing)
        }
        
        if let icon = style.trailingIcon, let image = UIImage(named: icon) {
            let button = Button(type: .custom, attributes: { button in
                button.setImage(image, for: .normal)
            }, action: { btn in
                if let callback = callback {
                    callback()
                }
            })
            button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            textfield.trailingView = button
            textfield.trailingViewMode = .always
        }
        textfield.setFilledBackgroundColor(.clear, for: .normal)
        textfield.setFilledBackgroundColor(.clear, for: .editing)
        textfield.returnKeyType = .next
        
        textfield.setNormalLabelColor(UIColor.TextField.normalText, for: .normal)
//        textfield.setTextColor(UIColor.TextField.activeText, for: .normal)
//        textfield.setTextColor(UIColor.TextField.activeText, for: .editing)
        
        textfield.setUnderlineColor(UIColor.TextField.inactivieField, for: .normal)
        textfield.setUnderlineColor(UIColor.TextField.activieField, for: .editing)
        return textfield
    }
    
}

