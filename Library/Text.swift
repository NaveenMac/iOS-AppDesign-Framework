//
//  Text.swift
//
//
//  Created by Naveen Chauhan on 02/02/21.
// 
//

import UIKit


public class Text: UILabel {
    init(text:String, attributes:((UILabel)->Void)?=nil){
        super.init(frame: CGRect.zero)
        self.text = text
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
