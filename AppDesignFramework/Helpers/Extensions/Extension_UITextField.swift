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
        textfield.leadingEdgePaddingOverride = 0.0
        textfield.tag = tag
        if let title = style.title {
            textfield.label.text = title.text
        
        }
        
        if let helperText = style.hint {
            textfield.leadingAssistiveLabel.text = helperText
            textfield.setLeadingAssistiveLabelColor(UIColor.lightGray, for: .normal)
            //textfield.setLeadingAssistiveLabelColor(UIColor.TextField.activieField, for: .editing)
        }
        textfield.setFilledBackgroundColor(.clear, for: .disabled)
        textfield.setFloatingLabelColor(UIColor.TextField.activieField, for: .editing)
        textfield.setFloatingLabelColor(UIColor.TextField.activeText, for: .normal)
        
//        textfield.setNormalLabelColor(.red, for: .normal)
//        textfield.setNormalLabelColor(.red, for: .editing)
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
        
        //textfield.setNormalLabelColor(UIColor.TextField.normalText, for: .normal)
        textfield.setTextColor(UIColor(hex: "#777777FF")!, for: .normal)
        textfield.setTextColor(UIColor.TextField.activeText, for: .editing)
        
        textfield.setUnderlineColor(UIColor.TextField.inactivieField, for: .normal)
        textfield.setUnderlineColor(UIColor.TextField.activieField, for: .editing)
        textfield.setUnderlineColor(UIColor.TextField.inactivieField, for: .disabled)
        return textfield
    }
    
    
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
            let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
            let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

            let toolbar: UIToolbar = UIToolbar()
            toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
            
            toolbar.sizeToFit()

            self.inputAccessoryView = toolbar
        }
    
    func addNextCancelToolbar(onNext: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
            let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
            let onNext = onNext ?? (target: self, action: #selector(doneButtonTapped))

            let toolbar: UIToolbar = UIToolbar()
            toolbar.barStyle = .default
        let next = UIBarButtonItem(title: "Next", style: .done, target: onNext.target, action: onNext.action)
        next.tag = self.tag
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            next
            
        ]
            
            toolbar.sizeToFit()

            self.inputAccessoryView = toolbar
        }
    
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
    
    
}


extension MDCFilledTextField {
    func setInputViewDatePicker(target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        
        let datePicker = UIDatePicker()//1
        
        let dateView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 358))
            dateView.addSubview(datePicker)
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: dateView.topAnchor, constant: 8).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: dateView.leadingAnchor, constant: 16).isActive = true
        datePicker.centerXAnchor.constraint(equalTo: dateView.centerXAnchor).isActive = true
        
        
        let maxDate = Date()
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
        
        
        datePicker.datePickerMode = .date //2
        datePicker.maximumDate = maxDate
        self.inputView = dateView //3
        
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
