//
//  Extension_UIFont.swift
//  FileManager
//
//  Created by Naveen Chauhan on 10/11/21.
//

import UIKit

extension UIFont {
    class func appRegularFontWith( size:CGFloat ) -> UIFont{
        
        return  UIFont(name: "OpenSans-Regular", size: size)!
    }
    
    func withWeight(_ weight: UIFont.Weight) -> UIFont {
            let newDescriptor = fontDescriptor.addingAttributes([.traits: [
          UIFontDescriptor.TraitKey.weight: weight]
        ])
        return UIFont(descriptor: newDescriptor, size: pointSize)
      }
    
    
}
