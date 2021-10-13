//
//  Form.swift
//
//
//  Created by Naveen Chauhan on 02/02/21.
//  
//

import UIKit
public class Form:UIStackView {
    
    init(title:String, elements:() -> [UIView]) {
        super.init(frame: CGRect.zero)
        self.alignment = .fill
        self.distribution = .fill
        self.axis = .vertical
        self.spacing = 12
        
        
        let label = Text(text: title)
        Theme.Form.formHeader(label: label)
        self.addArrangedSubview(label)
        let subviews = elements()
        for view in subviews {
            self.addArrangedSubview(view)
        }
//        UIView.transition(with: stack, duration: 3, options: [.transitionCurlUp, .showHideTransitionViews], animations: {
//            self.isHidden = false
//        }, completion: nil)
        
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.axis = .vertical
        self.spacing = 8.0
        self.distribution = .fill
        
        self.alignment = .fill
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

