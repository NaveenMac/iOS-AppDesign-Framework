//
//  HStack.swift
//
//
//  Created by Naveen Chauhan on 01/02/21.
//  
//

import UIKit
public class HStack:UIStackView {
    
    init(alignment:UIStackView.Alignment = .center,
         distribution:UIStackView.Distribution = .fill,
         spacing:CGFloat = 12.0,
         attributes:((UIStackView) -> Void)? = nil) {
        super.init(frame: CGRect.zero)
        self.axis = .horizontal
        self.spacing = spacing
        self.distribution = distribution
        if let block = attributes{
           block(self)
        }
        
        self.alignment = alignment
        
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.axis = .horizontal
        self.spacing = 12.0
        self.distribution = .fill
        
        self.alignment = .center
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
