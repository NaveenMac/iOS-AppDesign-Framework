//
//  Extension_UIAlert.swift
//  FileManager
//
//  Created by Naveen Chauhan on 25/11/21.
//

import UIKit

extension UIAlertController {
    
    static func showError(title:String,message:String)-> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default , handler:{ (UIAlertAction)in
           
        }))
       return alert
    }
   
}

extension UIAlertAction {
    var titleTextColor: UIColor? {
        get {
            return self.value(forKey: "titleTextColor") as? UIColor
        } set {
            self.setValue(newValue, forKey: "titleTextColor")
        }
    }
    
   
}
