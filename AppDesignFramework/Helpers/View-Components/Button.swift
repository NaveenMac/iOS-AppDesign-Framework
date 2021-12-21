//
//  Button.swift
//  FileManager
//
//  Created by Naveen Chauhan on 14/11/21.
//

import UIKit


public class Button: UIButton {
    
    // 2
        enum ButtonState {
            case normal
            case disabled
        }
        // 3
        private var disabledBackgroundColor: UIColor?
        private var defaultBackgroundColor: UIColor? {
            didSet {
                backgroundColor = defaultBackgroundColor
            }
        }
        
        // 4. change background color on isEnabled value changed
    public override var isEnabled: Bool {
            didSet {
                if isEnabled {
                    if let color = defaultBackgroundColor {
                        self.backgroundColor = color
                    }
                }
                else {
                    if let color = disabledBackgroundColor {
                        self.backgroundColor = color
                    }
                }
            }
        }
        
        // 5. our custom functions to set color for different state
        func setBackgroundColor(_ color: UIColor?, for state: ButtonState) {
            switch state {
            case .disabled:
                disabledBackgroundColor = color
            case .normal:
                defaultBackgroundColor = color
            }
        }
    
    init(title:String?=nil,
         titleColor:UIColor? = nil,
         backgroundColor:UIColor? = nil,
         type:UIButton.ButtonType = .custom,
         attributes:((UIButton)->Void )?=nil,
         action:@escaping ()->Void = {}){
        super.init(frame: CGRect.zero)
        if let text = title {
            self.setTitle(text, for: .normal)
        }
        
        if let fgColor = titleColor {
            self.setTitleColor(fgColor, for: .normal)
        }
        
        if let bgColor = backgroundColor {
            self.backgroundColor = bgColor
        }
        
        self.addAction(for: .touchUpInside, action)
        if let block = attributes {
            block(self)
        }
    }
    
    init(type:UIButton.ButtonType,
         attributes:((UIButton)->Void )?=nil,
         action:@escaping (UIControl)->Void = { control in }){
        super.init(frame: CGRect.zero)
       
        self.addAction1(for: .touchUpInside, action)
        if let block = attributes {
            block(self)
        }
    }
    
   
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
