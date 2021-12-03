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
        textfield.tag = tag
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


extension MDCFilledTextField {
    func setInputViewDatePicker(target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        
        
        let maxDate = Date()
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
        
        
        datePicker.datePickerMode = .date //2
        datePicker.maximumDate = maxDate
        self.inputView = datePicker //3
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
}
