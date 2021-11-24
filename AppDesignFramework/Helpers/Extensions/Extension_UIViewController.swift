//
//  Extension_UIViewController.swift
//  FileManager
//
//  Created by Naveen Chauhan on 23/11/21.
//

import UIKit


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
}
