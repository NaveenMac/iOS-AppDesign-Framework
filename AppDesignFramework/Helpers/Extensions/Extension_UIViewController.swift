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

        let toastLabel = PaddedLabel()
        toastLabel.paddingLeft = 40
        toastLabel.paddingRight  = 40
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        switch type {
        case .error:
            toastLabel.backgroundColor = UIColor.red
            toastLabel.textColor = UIColor.white
        case .success:
            toastLabel.backgroundColor = UIColor.green
            toastLabel.textColor = UIColor.white
        case .warning:
            toastLabel.backgroundColor = UIColor.yellow
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
            withVisualFormat: "H:|-30-[label]-30-|",
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
        
        UIView.animate(withDuration: 7, delay: 0.1, options: .curveLinear, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
           toastLabel.removeFromSuperview()
        })
    }
    
    
    
}
