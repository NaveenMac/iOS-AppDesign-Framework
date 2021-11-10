//
//  VIewProtocol.swift
//  FileManager
//
//  Created by Naveen Chauhan on 06/10/21.
//

import Foundation
import UIKit

protocol ViewProtocol {
    var order: Int?{set get}
    var tag: Int?{set get}
   
    func getView() -> UIView
}

extension ViewProtocol {
    func getView() -> UIView {
        return UIView()
    }
}
