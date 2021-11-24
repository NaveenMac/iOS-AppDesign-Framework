//
//  Extension_UIView.swift
//  FileManager
//
//  Created by Naveen Chauhan on 10/11/21.
//

import UIKit

extension UIView {
    
    func addActivityIndicator(size:CGSize = CGSize(width: 100, height: 100)) -> UIActivityIndicatorView{
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.tag = Int.Tags.activityIndicatorTag
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        self.addSubview(indicator)
        let views = ["indicator":indicator]
        let metrics = ["indicatorWidth":size.width, "indicatorHeight":size.height]
        var allConstraints = [NSLayoutConstraint]()
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[indicator(==indicatorWidth)]-|", options: [.alignAllCenterX], metrics: metrics, views: views)
        allConstraints += horizontalConstraints
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[indicator(==indicatorHeight)]-|", options: [.alignAllCenterY], metrics: metrics, views: views)
        allConstraints += verticalConstraints
        NSLayoutConstraint.activate(allConstraints)
        return indicator
    }
    
    func addUIProgressView(size:CGSize = CGSize(width: 270, height: 4))->UIProgressView{
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = .black
        progressView.progressTintColor = .blue
        progressView.tag = Int.Tags.progressView
        progressView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(progressView)
        self.bringSubviewToFront(progressView)
        let views = ["progressView":progressView]
        let metrics = ["width":size.width, "height":size.height]
        var allConstraints = [NSLayoutConstraint]()
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-40-[progressView]-40-|", options: [.alignAllCenterX], metrics: metrics, views: views)
        allConstraints += horizontalConstraints
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[progressView]", options: [.alignAllCenterY], metrics: metrics, views: views)
        allConstraints += verticalConstraints
        NSLayoutConstraint.activate(allConstraints)
        return progressView
    }
    
    func removeActivityIndicator(){
        if let indicator = self.viewWithTag(Int.Tags.activityIndicatorTag) as? UIActivityIndicatorView {
            indicator.removeFromSuperview()
        }
    }
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
    
    
    func addColors(colors: [UIColor]) {
       let gradientLayer = CAGradientLayer()
       gradientLayer.frame = self.bounds

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

       // This can be done outside of this funciton
       //self.layer.cornerRadius = self.bounds.height / 2
       self.layer.masksToBounds = true
   }
   
   // OUTPUT 1
     func dropShadow(scale: Bool = true) {
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
     func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
       layer.masksToBounds = false
       layer.shadowColor = color.cgColor
       layer.shadowOpacity = opacity
       layer.shadowOffset = offSet
       layer.shadowRadius = radius

       layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
       layer.shouldRasterize = true
       layer.rasterizationScale = scale ? UIScreen.main.scale : 1
     }
   
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
  
  
 static func  setPaddedLabelStyle(label:PaddedLabel, style:[Style]){
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
  
   static func setButtonStyle(button:UIButton, style:[Style]){
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
    
    func addShadowWithUploadIcon(){
       
        let shadow = UIView(frame: CGRect(x: 0, y: 0, width: 52, height: 52))
        shadow.accessibilityLabel = "Shadow"
        shadow.backgroundColor = .black
        shadow.alpha = 0.4
        self.addSubview(shadow)
    }
}

