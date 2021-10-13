//
//  ScrollView.swift
//
//
//  Created by Naveen Chauhan on 02/02/21.
//  
//

import UIKit


public class ScrollView: UIScrollView {
    
    
    init(axis:Axis, showsIndicators:Bool,content:UIView,attributes:((UIScrollView)->Void)?=nil){
        super.init(frame: CGRect.zero)
        
        content.translatesAutoresizingMaskIntoConstraints = false
        switch axis {
            case .vertical:
                if showsIndicators {
                    self.showsVerticalScrollIndicator = true
                }
                
            case .horizontal:
                if showsIndicators {
                    self.showsHorizontalScrollIndicator = true
                }
         }
        
       
        self.addSubview(content)
        if let block = attributes {
            block(self)
        }
        
        switch axis {
           case .vertical:
               if showsIndicators {
                   NSLayoutConstraint.activate([
                    content.widthAnchor.constraint(equalTo: self.widthAnchor),
                    ])
               }
               
           case .horizontal:
               NSLayoutConstraint.activate([
                           content.heightAnchor.constraint(equalTo: self.heightAnchor)
              
                ])
        }
        
        NSLayoutConstraint.activate([
            content.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            content.topAnchor.constraint(equalTo: self.topAnchor),
            content.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
        
        switch axis {
           case .vertical:
            self.contentSize = CGSize(width: content.frame.size.width, height: content.frame.size.height+100)
               
           case .horizontal:
            self.contentSize = CGSize(width: content.frame.size.width, height: content.frame.size.height)
        }
        
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

