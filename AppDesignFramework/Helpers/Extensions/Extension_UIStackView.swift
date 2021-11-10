//
//  Extension_UIStackView.swift
//  FileManager
//
//  Created by Naveen Chauhan on 10/11/21.
//

import UIKit

extension UIStackView {
    func addStackColors(colors: [UIColor],bounds:CGRect ) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        var colorsArray: [CGColor] = []
        var locationsArray: [NSNumber] = []
        for (index, color) in colors.enumerated() {
            // append same color twice
            colorsArray.append(color.cgColor)
            colorsArray.append(color.cgColor)
            locationsArray.append(NSNumber(value: (1.0 / Double(colors.count)) * Double(index)))
            locationsArray.append(NSNumber(value: (1.0 / Double(colors.count)) * Double(index + 1)))
        }

        gradientLayer.colors = colorsArray
        gradientLayer.locations = locationsArray

        self.backgroundColor = .clear
        self.layer.addSublayer(gradientLayer)

        let subView = UIView(frame: bounds)
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subView.layer.addSublayer(gradientLayer)
        //subView.layer.borderColor = Theme.Color.lightGray.cgColor
        
        insertSubview(subView, at: 0)
        
        // This can be done outside of this funciton
        //self.layer.cornerRadius = self.bounds.height / 2
        //self.layer.masksToBounds = true
    }
    
    func addBackground(color: UIColor,borderWidth:CGFloat = 0.5) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subView.layer.borderWidth = borderWidth
        //subView.layer.borderColor = Theme.Color.lightGray.cgColor
        if borderWidth > 0 {
          subView.layer.cornerRadius = 10
        }
        
        insertSubview(subView, at: 0)
    }
    
    func addBackgroundImage(image:UIImage, color: UIColor?) {
        let subView = UIImageView(frame: bounds)
        subView.image = image
        if let col = color {
            subView.backgroundColor = col
        }
        
        subView.alpha = 0.9
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
    
    func reverseSubviewsZIndex(setNeedsLayout: Bool = true) {
      let stackedViews = self.arrangedSubviews

      stackedViews.forEach {
        self.removeArrangedSubview($0)
        $0.removeFromSuperview()
      }

      stackedViews.reversed().forEach(addSubview(_:))
      stackedViews.forEach(addArrangedSubview(_:))

      if setNeedsLayout {
        stackedViews.forEach { $0.setNeedsLayout() }
      }
    }
   
}
