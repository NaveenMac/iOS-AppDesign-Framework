//
//  CustomUIBarButtonItem.swift
//
//
//  Created by Naveen Chauhan on 26/06/20.
//  
//

import UIKit

struct CustomView {
    func Circle(radius:CGFloat, attributes:@escaping (UIView)->Void) -> UIView{
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 2 * radius, height: 2 * radius))
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 2 * radius),
            view.heightAnchor.constraint(equalToConstant: 2 * radius)
        ])
        view.makeCircle(radius: radius, attributes: attributes)
        return view
    }
    
    func setRightTriangle(triangleView:UIView, color:CGColor)->UIView{
        let heightWidth = triangleView.frame.size.width //you can use triangleView.frame.size.height
        let path = CGMutablePath()

        path.move(to: CGPoint(x: heightWidth/2, y: 0))
        path.addLine(to: CGPoint(x:heightWidth, y: heightWidth/2))
        path.addLine(to: CGPoint(x:heightWidth/2, y:heightWidth))
        path.addLine(to: CGPoint(x:heightWidth/2, y:0))

        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.blue.cgColor

        triangleView.layer.insertSublayer(shape, at: 0)
        return triangleView
    }
    
    func setLeftTriangle(triangleView:UIView, color:CGColor) ->UIView{
        let heightWidth = triangleView.frame.size.width
        let path = CGMutablePath()

        path.move(to: CGPoint(x: heightWidth/2, y: 0))
        path.addLine(to: CGPoint(x:0, y: heightWidth/2))
        path.addLine(to: CGPoint(x:heightWidth/2, y:heightWidth))
        path.addLine(to: CGPoint(x:heightWidth/2, y:0))

        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.blue.cgColor

        triangleView.layer.insertSublayer(shape, at: 0)
        return triangleView
    }
    
    
    func setUpTriangle(triangleView:UIView, color:CGColor) -> UIView{
     let heightWidth = triangleView.frame.size.width
        let path = CGMutablePath()

        path.move(to: CGPoint(x: 0, y: heightWidth))
        path.addLine(to: CGPoint(x:heightWidth/2, y: heightWidth/2))
        path.addLine(to: CGPoint(x:heightWidth, y:heightWidth))
        path.addLine(to: CGPoint(x:0, y:heightWidth))

        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = color

        triangleView.layer.insertSublayer(shape, at: 0)
        return triangleView
    }
    
    func setDownTriangle(triangleView:UIView, color:CGColor)->UIView{
        let heightWidth = triangleView.frame.size.width
        let path = CGMutablePath()

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x:heightWidth/2, y: heightWidth/2))
        path.addLine(to: CGPoint(x:heightWidth, y:0))
        path.addLine(to: CGPoint(x:0, y:0))

        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = color

        triangleView.layer.insertSublayer(shape, at: 0)
        return triangleView
    }
    
    func Spacer(constant:CGFloat) -> UIView{
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: constant).isActive = true
        return view
    }
    
    /// Description
    /// - Parameters:
    ///   - radius: <#radius description#>
    ///   - attributes: <#attributes description#>
    func Cirlce(radius:CGFloat, attributes:@escaping (UIView)->Void) ->UIView{
        let circle = self.Circle(radius: radius, attributes: attributes)
        return circle
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - view: <#view description#>
    ///   - direction: <#direction description#>
    func Triangle(view:UIView, direction:Direction, color:CGColor) -> UIView{
        var triangleView = view
        switch direction {
        case .up:
            triangleView = self.setUpTriangle(triangleView: triangleView,color: UIColor.black.cgColor)
        case .down:
            triangleView = self.setDownTriangle(triangleView: triangleView, color: color)
        case .left:
            triangleView = self.setLeftTriangle(triangleView: triangleView, color: color)
        case .right:
            triangleView = self.setRightTriangle(triangleView: triangleView, color: color)
        }
        return triangleView
    }
    
}


