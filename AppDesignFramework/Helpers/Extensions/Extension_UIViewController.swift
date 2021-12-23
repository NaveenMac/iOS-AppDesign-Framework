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
    
    func animateWithKeyboard(
        notification: NSNotification,
        animations: ((_ keyboardFrame: CGRect) -> Void)?
    ) {
        // Extract the duration of the keyboard animation
        let durationKey = UIResponder.keyboardAnimationDurationUserInfoKey
        let duration = notification.userInfo![durationKey] as! Double
        
        // Extract the final frame of the keyboard
        let frameKey = UIResponder.keyboardFrameEndUserInfoKey
        let keyboardFrameValue = notification.userInfo![frameKey] as! NSValue
        
        // Extract the curve of the iOS keyboard animation
        let curveKey = UIResponder.keyboardAnimationCurveUserInfoKey
        let curveValue = notification.userInfo![curveKey] as! Int
        let curve = UIView.AnimationCurve(rawValue: curveValue)!

        // Create a property animator to manage the animation
        let animator = UIViewPropertyAnimator(
            duration: duration,
            curve: curve
        ) {
            // Perform the necessary animation layout updates
            animations?(keyboardFrameValue.cgRectValue)
            
            // Required to trigger NSLayoutConstraint changes
            // to animate
            self.view?.layoutIfNeeded()
        }
        
        // Start the animation
        animator.startAnimation()
    }
    
    func animateTextField(textField: UITextField, up: Bool) {
        
        let movementDistance:CGFloat = -130
        let movementDuration: Double = 0.3
        
        var movement:CGFloat = 0
        if up {
            movement = movementDistance
        } else {
            movement = -movementDistance
        }
        
        UIView.animate(withDuration: movementDuration, delay: 0, options: [.beginFromCurrentState], animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        }, completion: nil)
    }
    
    @objc func goToNextField(sender:UIBarButtonItem){
        self.view.endEditing(true)
      let tag = sender.tag
        
        if let textfield = self.view.viewWithTag(tag+1) as? UITextField{
            textfield.becomeFirstResponder()
        }
    }
    
    func changeTopBarColor(color:UIColor){
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = color
        self.navigationController?.navigationBar.backgroundColor = color
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            var statusBarHeight: CGFloat
            if UIDevice().hasNotch {
               statusBarHeight = app.statusBarFrame.size.height+20
            }else{
                statusBarHeight = app.statusBarFrame.size.height
            }
            
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = color
            view.addSubview(statusbarView)
          
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
          
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = color
        }
        self.navigationController?.navigationBar.isHidden = false
    }
    
}
