//
//  Extension_UIBarButtonItem.swift
//  UserProfile
//
//  Created by Naveen Chauhan on 16/12/21.
//

import UIKit

extension UIBarButtonItem {
    func customBackButton(image:String, callback:@escaping(()->Void))->UIBarButtonItem{
        let button = Button(type: .custom, attributes: { button in
            button.setImage(UIImage(named: image), for: .normal)
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left:-30, bottom: 0, right: 0)
            button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        }){ button in
            callback()
        }
        
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }
}


