//
//  Image.swift
//
//
//  Created by Naveen Chauhan on 02/02/21.
//  
//

import UIKit


public class Image: UIImageView {
    lazy var contentImageView:UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "no-image"))
        return imageView
    }()
    lazy var originalImage:UIImage = {
       let noImage = UIImage(named: "no-image")
        return noImage!
    }()
    
    init(named:String = "", systemName:String="", attributes:((UIImageView?)->Void)?=nil){
        super.init(frame: CGRect.zero)
        if !named.isEmpty {
            originalImage = UIImage(named: named)!
           
        }else {
            if #available(iOS 13.0, *) {
                originalImage = UIImage(systemName: systemName)!
                
            } else {
                // Fallback on earlier versions
                originalImage = UIImage(named: named)!
                
            }
            
        }
        self.image = originalImage
        
        if let block = attributes {
            block(self)
        }
        
        
    }
    
   
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

