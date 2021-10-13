//
//  ZStack.swift
//
//
//  Created by Naveen Chauhan on 02/02/21.
//  
//

import UIKit

public class ZStack:ZView {
   
    init(frame:CGRect? = nil,
         attributes:((ZView) -> Void)? = nil){
        if let fr = frame {
            super.init(frame: fr)
        }else{
            super.init()
        }
         
        
        if let block = attributes {
            block(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}
