//
//  Extension.swift
//  FileManager
//
//  Created by Naveen Chauhan on 07/10/21.
//

import UIKit

extension UIView {
  func addTopBorderWithColor(color: UIColor, width: CGFloat) {
    let border = CALayer()
    border.backgroundColor = color.cgColor
    border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
    self.layer.addSublayer(border)
  }

  func addRightBorderWithColor(color: UIColor, width: CGFloat) {
    let border = CALayer()
    border.backgroundColor = color.cgColor
    border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
    self.layer.addSublayer(border)
  }

  func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
    let border = CALayer()
    border.backgroundColor = color.cgColor
    border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
    self.layer.addSublayer(border)
  }

  func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
    let border = CALayer()
    border.backgroundColor = color.cgColor
    border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
    self.layer.addSublayer(border)
  }
}

extension Data{
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
       if let data = string.data(using: encoding) {
        append(data)
    }
  }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
    
        
}

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

extension UIView {
//    static func addColors(colors: [UIColor]) {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = self.bounds
//
//        var colorsArray: [CGColor] = []
//        var locationsArray: [NSNumber] = []
//        for (index, color) in colors.enumerated() {
//            // append same color twice
//            colorsArray.append(color.cgColor)
//            colorsArray.append(color.cgColor)
//            locationsArray.append(NSNumber(value: (1.0 / Double(colors.count)) * Double(index)))
//            locationsArray.append(NSNumber(value: (1.0 / Double(colors.count)) * Double(index + 1)))
//        }
//
//        gradientLayer.colors = colorsArray
//        gradientLayer.locations = locationsArray
//
//        self.backgroundColor = .clear
//        self.layer.addSublayer(gradientLayer)
//
//        // This can be done outside of this funciton
//        //self.layer.cornerRadius = self.bounds.height / 2
//        self.layer.masksToBounds = true
//    }
    
   static func VStack(spacing:CGFloat,alignment:UIStackView.Alignment = .top, distribution:UIStackView.Distribution)->UIStackView{
       let stack = UIStackView()
       stack.axis = .vertical
       stack.spacing = spacing
       stack.alignment = alignment
       stack.distribution = distribution
       return stack
   }
   
  static func HStack(spacing:CGFloat,alignment:UIStackView.Alignment = .leading, distribution:UIStackView.Distribution)->UIStackView{
       let stack = UIStackView()
       stack.axis = .horizontal
       stack.alignment = alignment
       stack.spacing = spacing
       stack.distribution = distribution
       return stack
   }
   
   
  static func setPaddedLabelStyle(label:PaddedLabel, style:[Style]){
       for property in style {
           switch property.attr {
           case Attributes.textColor.rawValue:
               label.textColor = UIColor(hex: property.value!)
           case Attributes.backgroundColor.rawValue:
               label.textColor = UIColor(hex: property.value!)
           case Attributes.fontWeight.rawValue:
               switch property.value! {
               case "700":
                   label.font = UIFont.systemFont(ofSize: label.font!.pointSize, weight: .bold)
                   
               case "400":
                   label.font = UIFont.systemFont(ofSize: label.font!.pointSize, weight: .regular)
               default:
                   label.font = UIFont.systemFont(ofSize: label.font!.pointSize, weight: .medium)
               }
               
               
           case Attributes.fontFamily.rawValue:

               if let font =  UIFont(name: property.value!, size: label.font.pointSize) {
                   label.font = font
               }else{
                   label.font = UIFont.appRegularFontWith(size:label.font.pointSize)
               }
           case Attributes.fontSize.rawValue:
               label.font = UIFont.appRegularFontWith(size:CGFloat((property.value! as NSString).floatValue))
           case Attributes.topPadding.rawValue:
               label.paddingTop = CGFloat((property.value! as NSString).floatValue)
           case Attributes.leftPadding.rawValue:
               label.paddingLeft = CGFloat((property.value! as NSString).floatValue)
           case Attributes.rightPadding.rawValue:
               label.paddingRight = CGFloat((property.value! as NSString).floatValue)
           case Attributes.bottomPadding.rawValue:
               label.paddingBottom = CGFloat((property.value! as NSString).floatValue)
           case Attributes.textAlignment.rawValue:
               switch property.value! {
                   case "center":
                       label.textAlignment = .center
                       
                   case "left":
                       label.textAlignment = .left
                   case "right":
                       label.textAlignment = .right
                   default:
                       label.textAlignment = .justified
               }
               
           case Attributes.width.rawValue:
               NSLayoutConstraint.activate([
                   label.widthAnchor.constraint(equalToConstant:CGFloat((property.value! as NSString).floatValue))
               ])
               
              
           default:
               print("NA")
           }
       }
   }
   
    static func setUIButtonStyle(button:UIButton, style:[Style]){
       for property in style {
           switch property.attr {
           case Attributes.width.rawValue:
               NSLayoutConstraint.activate([
                   button.widthAnchor.constraint(equalToConstant:CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.height.rawValue:
               NSLayoutConstraint.activate([
                   button.heightAnchor.constraint(equalToConstant:CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.textColor.rawValue:
               button.titleLabel?.textColor = UIColor(hex: property.value!)
           case Attributes.backgroundColor.rawValue:
               button.backgroundColor = UIColor(hex: property.value!)
           case Attributes.fontSize.rawValue:
           button.titleLabel?.font = UIFont.appRegularFontWith(size:CGFloat((property.value! as NSString).floatValue))
           case Attributes.width.rawValue:
               NSLayoutConstraint.activate([
                   button.widthAnchor.constraint(equalToConstant:CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.cornerRadius.rawValue:
               button.layer.cornerRadius = CGFloat((property.value! as NSString).floatValue)
               button.layer.masksToBounds = true
               
              
           default:
               print("NA")
           }
       }
   }
   
   
    static func setImageViewStyle(image:UIImageView, style:[Style]){
       for property in style {
           switch property.attr {
           case Attributes.width.rawValue:
               NSLayoutConstraint.activate([
                   image.widthAnchor.constraint(equalToConstant:CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.height.rawValue:
               NSLayoutConstraint.activate([
                   image.heightAnchor.constraint(equalToConstant:CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.imageNamed.rawValue:
               image.image = UIImage(named: property.value!)
           case Attributes.contentMode.rawValue:
               switch property.value {
                   case "aspectFit":
                       image.contentMode = .scaleAspectFit
                   case "center":
                       image.contentMode = .center
                   default:
                       print("NA")
               }
               
           case Attributes.topMargin.rawValue:
               if let st = image.superview as? UIStackView {
                   st.directionalLayoutMargins = NSDirectionalEdgeInsets(top: CGFloat((property.value! as NSString).floatValue), leading: 0, bottom: 0, trailing: 0)
                   st.isLayoutMarginsRelativeArrangement = true
               }
           
           case Attributes.tintColor.rawValue:
               image.tintColor = UIColor(hex: property.value ?? "#2196F3FF")
           case Attributes.cornerRadius.rawValue:
               image.layer.cornerRadius = CGFloat((property.value! as NSString).floatValue)
               image.layer.masksToBounds = true
           case Attributes.borderWidth.rawValue:
               image.layer.borderWidth = CGFloat((property.value! as NSString).floatValue)
               image.layer.masksToBounds = true
           case Attributes.borderColor.rawValue:
               if let color = UIColor(hex: property.value!) {
                   image.layer.borderColor = color.cgColor
                   image.layer.masksToBounds = true
               }
               
           default:
               print("NA")
           }
       }
   }
   
    static func setStackViewStyle(stack:UIView, style:[Style]){
       for property in style {
           switch property.attr {
           case Attributes.cornerRadius.rawValue:
               stack.layer.cornerRadius = CGFloat((property.value! as NSString).floatValue)
               stack.layer.masksToBounds = true
               
             
           case Attributes.width.rawValue:
               NSLayoutConstraint.activate([
                   stack.widthAnchor.constraint(equalToConstant:CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.height.rawValue:
               NSLayoutConstraint.activate([
                   stack.heightAnchor.constraint(equalToConstant:CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.backgroundColor.rawValue:
               stack.backgroundColor = UIColor(hex: property.value!)
           case Attributes.margin.rawValue:
               
               if let st = stack as? UIStackView,let value = property.value as NSString? ,let arr = value.components(separatedBy: ",") as? [NSString]{
                    
                       
                   let leading = CGFloat(arr[0].floatValue)
                       let top = CGFloat(arr[1].floatValue)
                     let trailing = CGFloat(arr[2].floatValue)
                   let bottom = CGFloat(arr[3].floatValue)
                       st.directionalLayoutMargins = NSDirectionalEdgeInsets(top:top , leading: leading, bottom: bottom, trailing: trailing)
                   st.isLayoutMarginsRelativeArrangement = true
                       
                   }
                 
               
           case Attributes.topMargin.rawValue:
               
               if let st = stack as? UIStackView {
                   
                   st.directionalLayoutMargins = NSDirectionalEdgeInsets(top: CGFloat((property.value! as NSString).floatValue), leading: 0, bottom: 0, trailing: 0)
                   st.isLayoutMarginsRelativeArrangement = true
               }
       
           case Attributes.leftMargin.rawValue:
               if let st = stack as? UIStackView {
                   st.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: CGFloat((property.value! as NSString).floatValue), bottom: 0, trailing: 0)
                   st.isLayoutMarginsRelativeArrangement = true
                   st.translatesAutoresizingMaskIntoConstraints = false
               }
           case Attributes.leftRightMargin.rawValue:
               if let st = stack as? UIStackView {
                   let margin:CGFloat = CGFloat((property.value! as NSString).floatValue)
                   st.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: margin, bottom: 0, trailing: margin)
                   st.isLayoutMarginsRelativeArrangement = true
                   st.translatesAutoresizingMaskIntoConstraints = false
               }
               
           case Attributes.cornerRadius.rawValue:
               if let st = stack as? UIStackView {
                   st.layer.cornerRadius = CGFloat((property.value! as NSString).floatValue)
                   st.layer.masksToBounds = true
                   
               }
               
           case Attributes.borderWidth.rawValue:
               if let st = stack as? UIStackView {
               st.layer.borderWidth = CGFloat((property.value! as NSString).floatValue)
               st.layer.masksToBounds = true
               }
           case Attributes.borderColor.rawValue:
               
               if let st = stack as? UIStackView, let color = UIColor(hex: property.value!) {
                   st.layer.borderColor = color.cgColor
                   st.layer.masksToBounds = true
               }
           default:
               print("NA")
           }
       }
   }
   
    static func setStackViewRelativeStyle(view:UIView,relativeView:UIView, style:[Style]){
       for property in style {
           switch property.attr {
           case Attributes.relativeWidthRatio.rawValue:
               NSLayoutConstraint.activate([
                   view.widthAnchor.constraint(equalTo:relativeView.widthAnchor, multiplier: CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.relativeHeightRatio.rawValue:
               NSLayoutConstraint.activate([
                   view.heightAnchor.constraint(equalTo:relativeView.heightAnchor, multiplier: CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.relativeWidth.rawValue:
               NSLayoutConstraint.activate([
                   view.widthAnchor.constraint(equalTo:relativeView.widthAnchor, constant: CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.relativeHeight.rawValue:
               NSLayoutConstraint.activate([
                   view.heightAnchor.constraint(equalTo:relativeView.heightAnchor, constant: CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.relativeTopAnchor.rawValue:
               NSLayoutConstraint.activate([
                   view.topAnchor.constraint(equalTo:relativeView.topAnchor, constant: CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.relativeTopAnchorRatio.rawValue:
               NSLayoutConstraint.activate([
                   view.topAnchor.constraint(equalToSystemSpacingBelow: relativeView.topAnchor, multiplier: CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.relativeBottomAnchor.rawValue:
               NSLayoutConstraint.activate([
                   view.bottomAnchor.constraint(equalTo:relativeView.topAnchor, constant: CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.relativeRightAnchor.rawValue:
               NSLayoutConstraint.activate([
                   view.rightAnchor.constraint(equalTo:relativeView.rightAnchor, constant: CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.relativeLeftAnchor.rawValue:
               NSLayoutConstraint.activate([
                   view.leftAnchor.constraint(equalTo:relativeView.leftAnchor, constant: CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.relativeCenterXAnchor.rawValue:
               NSLayoutConstraint.activate([
                   view.centerXAnchor.constraint(equalTo:relativeView.centerXAnchor, constant: CGFloat((property.value! as NSString).floatValue))
               ])
           default:
               print("NA")
           }
       }
   }
   
    static func setTableViewStyle(table:UITableView, style:[Style]){
       
       for property in style {
           switch property.attr {
           case Attributes.backgroundColor.rawValue:
               table.backgroundColor = UIColor(hex: property.value!)
           case Attributes.cornerRadius.rawValue:
               table.layer.cornerRadius = CGFloat((property.value! as NSString).floatValue)
               table.layer.masksToBounds = true
           case Attributes.borderWidth.rawValue:
               table.layer.borderWidth = CGFloat((property.value! as NSString).floatValue)
               table.layer.masksToBounds = true
           case Attributes.borderColor.rawValue:
               if let color = UIColor(hex: property.value!) {
                   table.layer.borderColor = color.cgColor
                   table.layer.masksToBounds = true
               }
           case Attributes.borderColor.rawValue:
               if let color = UIColor(hex: property.value!) {
                   table.layer.borderColor = color.cgColor
                   table.layer.masksToBounds = true
               }
           default:
               print("NA")
           }
       }
   }
   
    static func setViewRelativeStyle(view:UIView, style:[Style], relativeView: UIView){
       
       for property in style {
           switch property.attr {
           case Attributes.relativeWidthRatio.rawValue:
               NSLayoutConstraint.activate([
                   view.widthAnchor.constraint(equalTo:relativeView.widthAnchor, multiplier: CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.relativeHeightRatio.rawValue:
               NSLayoutConstraint.activate([
                   view.heightAnchor.constraint(equalTo:relativeView.heightAnchor, multiplier: CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.relativeWidth.rawValue:
               NSLayoutConstraint.activate([
                   view.widthAnchor.constraint(equalTo:relativeView.widthAnchor, constant: CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.relativeHeight.rawValue:
               NSLayoutConstraint.activate([
                   view.heightAnchor.constraint(equalTo:relativeView.heightAnchor, constant: CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.relativeTopAnchor.rawValue:
               NSLayoutConstraint.activate([
                   view.topAnchor.constraint(equalTo:relativeView.topAnchor, constant: CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.relativeTopAnchorRatio.rawValue:
               NSLayoutConstraint.activate([
                   view.topAnchor.constraint(equalToSystemSpacingBelow: relativeView.topAnchor, multiplier: CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.relativeBottomAnchor.rawValue:
               NSLayoutConstraint.activate([
                   view.bottomAnchor.constraint(equalTo:relativeView.bottomAnchor, constant: CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.relativeRightAnchor.rawValue:
               NSLayoutConstraint.activate([
                   view.rightAnchor.constraint(equalTo:relativeView.rightAnchor, constant: -CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.relativeLeftAnchor.rawValue:
               NSLayoutConstraint.activate([
                   view.leftAnchor.constraint(equalTo:relativeView.leftAnchor, constant: CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.relativeCenterXAnchor.rawValue:
               NSLayoutConstraint.activate([
                   view.centerXAnchor.constraint(equalTo:relativeView.centerXAnchor, constant: CGFloat((property.value! as NSString).floatValue))
               ])
           default:
               print("NA")
           }
       }
   }
   
    static func setZStackStyle(view:UIView, style:[Style]){
       for property in style {
           switch property.attr {
           case Attributes.width.rawValue:
               NSLayoutConstraint.activate([
                   view.widthAnchor.constraint(equalToConstant:CGFloat((property.value! as NSString).floatValue))
               ])
           case Attributes.height.rawValue:
               NSLayoutConstraint.activate([
                   view.heightAnchor.constraint(equalToConstant:CGFloat((property.value! as NSString).floatValue))
               ])
            
           default:
               print("NA")
           }
       }
   }
}

