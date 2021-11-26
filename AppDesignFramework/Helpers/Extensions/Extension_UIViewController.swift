//
//  Extension_UIViewController.swift
//  FileManager
//
//  Created by Naveen Chauhan on 23/11/21.
//

import UIKit

enum ToastType{
    case error
    case success
    case warning
    case custom
}

extension UIViewController {
    func displayContentController(content:UIViewController){
        addChild(content)
        self.view.addSubview(content.view)
        content.didMove(toParent: self)
    }
    
    func remoteContentController(content:UIViewController){
        content.willMove(toParent: nil)
        content.view.removeFromSuperview()
        content.removeFromParent()
    }
    
    func showToast(type:ToastType,message : String, font: UIFont) {
        DispatchQueue.main.async {
            let toastLabel = PaddedLabel()
            toastLabel.paddingLeft = 15
            toastLabel.paddingRight = 15
            toastLabel.paddingTop = 15
            toastLabel.paddingBottom = 15
            toastLabel.font = UIFont.appRegularFontWith(size: 14)
            toastLabel.translatesAutoresizingMaskIntoConstraints = false
            switch type {
            case .error:
                toastLabel.backgroundColor = UIColor(hex: "#FF0000FF")
                toastLabel.textColor = UIColor.white
            case .success:
                toastLabel.backgroundColor = UIColor(hex: "#28A745FF")
                toastLabel.textColor = UIColor.white
            case .warning:
                toastLabel.backgroundColor = UIColor(hex: "#FFC106FF")
                toastLabel.textColor = UIColor.black
            case .custom:
                toastLabel.backgroundColor = UIColor(hex: "#343A3FFF")
                toastLabel.textColor = UIColor.black
            }
            toastLabel.font = font
            toastLabel.textAlignment = .center;
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            
            let window = UIApplication.shared.keyWindow!
            
            window.addSubview(toastLabel)
            
            var allConstraints = [NSLayoutConstraint]()
            var HConstraints = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-31-[label]-31-|",
                options: NSLayoutConstraint.FormatOptions.alignAllCenterX,
              metrics: nil,
                views: ["superview":window, "label":toastLabel])

            
            allConstraints += HConstraints
            let VConstraints = NSLayoutConstraint.constraints(
                withVisualFormat: "V:[label]-80-|",
                options: NSLayoutConstraint.FormatOptions.alignAllCenterY,
              metrics: nil,
                views: ["superview":window, "label":toastLabel])
            allConstraints += VConstraints
            NSLayoutConstraint.activate(allConstraints)
            toastLabel.transform = CGAffineTransform(translationX: 0, y: 500)
            
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5, options: [], animations: {
                toastLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: {_ in
                UIView.animate(withDuration: 0.7, delay: 5.0, options: [], animations: {
                    toastLabel.transform = CGAffineTransform(translationX: -500, y: 0)
                }, completion: {_ in
                    toastLabel.removeFromSuperview()
                    })
                })
        
        }
        
    }
    
}
