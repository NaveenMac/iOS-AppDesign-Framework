//
//  Button.swift
//
//
//  Created by Naveen Chauhan on 02/02/21.
//  
//

import UIKit


public class Button: UIButton {
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
