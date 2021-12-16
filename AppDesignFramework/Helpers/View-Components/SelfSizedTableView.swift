//
//  SelfSizedTableView.swift
//  Venue App
//
//  Created by Jahid Hasan Polash on 4/6/18.
//  Copyright © 2018 InfancyIT. All rights reserved.
//  Reference: https://medium.com/@dushyant_db/swift-4-recipe-self-sizing-table-view-2635ac3df8ab
import UIKit

class SelfSizedTableView: UITableView {
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height
    var showShadow:Bool = false
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
        if showShadow {
            if self.contentSize.height > 1 || self.contentSize.width > 1 {
//                self.layer.shadowColor = UIColor(hex: "#A7A7A7FF")?.cgColor ?? UIColor.black.cgColor
//                self.layer.shadowOpacity = 1
//                self.layer.shadowOffset = .zero
//                self.layer.shadowRadius = 10
//                self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
                self.dropTableShadow(color: UIColor(hex: "#A7A7A7FF") ?? .clear, opacity: 0.1, offSet:CGSize(width:1,height:1), radius: 10.0, scale: true)
            }
           
        }
    }
    
    override var intrinsicContentSize: CGSize {
        setNeedsLayout()
        layoutIfNeeded()
        let height = min(contentSize.height, maxHeight)
    
        return CGSize(width: contentSize.width, height: height)
    }
    
    // OUTPUT 1
    func dropTableShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1

        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }

      // OUTPUT 2
      func dropTableShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }
    
}
