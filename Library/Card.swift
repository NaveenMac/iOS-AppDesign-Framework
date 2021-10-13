//
//  Card.swift
//
//
//  Created by Naveen Chauhan on 02/02/21.
//  
//

import UIKit
public class Card: UIStackView {
    
    init(type:CardType,size:CGSize,alignment:Axis = .vertical,action:@escaping ()->Void = {},attributes:((UIStackView)->Void)?=nil){
        super.init(frame: CGRect.zero)
        
        switch type {
            case .type1:
                Card1(attributes: attributes)
            break
            case .type2:
                Card2(alignment:alignment,attributes: attributes)
                break
            case .type3:
                Card3(alignment:alignment,attributes: attributes)
                break
            
            case .type4:
                 Card4(alignment:alignment,action:action,attributes: attributes)
                break
        }
       
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: size.height),
            self.widthAnchor.constraint(equalToConstant: size.width)
        ])
        if let block = attributes {
            self.translatesAutoresizingMaskIntoConstraints = false
            
            block(self)
        }
    }
    
    
    func getCard()->UIStackView{
        return self
    }
    /// Description
    /// - Parameters:
    ///   - view: <#view description#>
    ///   - direction: <#direction description#>
    func Card1(attributes:((UIStackView)->Void)?=nil){
        
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = 8
        do{
            let img = Image(named: "no-image")
            self.addArrangedSubview(img)
            img.tag = 1
            
        }catch{
            
        }
        
       
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - view: <#view description#>
    ///   - direction: <#direction description#>
    func Card2(alignment:Axis, attributes:((UIStackView)->Void)?=nil){
        let parent:UIStackView
        
        if(alignment == .vertical){
            self.axis = .vertical
            self.alignment = .fill
            self.distribution = .fill
            self.spacing = 8
            
        }else{
            self.axis = .horizontal
            self.alignment = .fill
            self.distribution = .fill
            self.spacing = 8
           
        }
        
        
        do{
           let img = Image(named: "no-image")
            self.addArrangedSubview(img)
            NSLayoutConstraint.activate([
                img.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8)
            ])
            img.tag = 1
            img.translatesAutoresizingMaskIntoConstraints = false
            
            let detailWrapper = VStack(alignment:.fill, distribution:.fill, spacing: 3, attributes: {stack in
                stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5)
                stack.isLayoutMarginsRelativeArrangement = true
                let title = Text(text: "",attributes: {label in
                    label.textColor = .darkGray
                    label.font = Theme.Font.calloutBold
                    label.tag = 2
                    
                })
                
                stack.addArrangedSubview(title)
                
                
            })
            
            
            self.addArrangedSubview(detailWrapper)
        }catch{
            
        }
        
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - view: <#view description#>
    ///   - direction: <#direction description#>
    func Card3(alignment:Axis, attributes:((UIStackView)->Void)?=nil){
        if(alignment == .vertical){
            self.axis = .vertical
            self.alignment = .fill
            self.distribution = .fill
            self.spacing = 8
            
        }else{
            self.axis = .horizontal
            self.alignment = .fill
            self.distribution = .fill
            self.spacing = 8
           
        }
        
        
        do{
            let img = Image(named: "no-image")
            self.addArrangedSubview(img)
            NSLayoutConstraint.activate([
                img.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6)
            ])
            img.tag = 1
            img.translatesAutoresizingMaskIntoConstraints = false
            
            let detailWrapper = VStack(alignment:.fill, distribution:.fill, spacing: 3, attributes: {stack in
                stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5)
                stack.isLayoutMarginsRelativeArrangement = true
                let title = Text(text:"",attributes: {label in
                    label.textColor = .darkGray
                    label.font = Theme.Font.calloutBold
                    label.tag = 2
                    label.heightAnchor.constraint(equalToConstant: 15).isActive = true
                    label.translatesAutoresizingMaskIntoConstraints = false
                    
                })
                let detail = Text(text:"",attributes: {label in
                    label.tag = 3
                    label.textColor = .darkGray
                    label.numberOfLines = 0
                    label.lineBreakMode = .byWordWrapping
                })
                stack.addArrangedSubview(title)
                stack.addArrangedSubview(detail)
                
            })
            
            
            self.addArrangedSubview(detailWrapper)
        }catch{
            
        }
        
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - view: <#view description#>
    ///   - direction: <#direction description#>
    func Card4(alignment:Axis,action:@escaping ()->Void = {}, attributes:((UIStackView)->Void)?=nil){
        var mainContentWrapper:UIStackView
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = 8
        if(alignment == .vertical){
            mainContentWrapper = VStack(alignment:.fill, distribution:.fill)
        }else{
            
            mainContentWrapper = HStack(alignment:.fill, distribution:.fill)
           
        }
        
        
        do{
            
            mainContentWrapper.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8)
            mainContentWrapper.isLayoutMarginsRelativeArrangement = true
            let img = Image(named: "no-image",attributes: {imageView in
                
                imageView?.contentMode = .scaleAspectFit
                imageView?.translatesAutoresizingMaskIntoConstraints = false
                imageView?.tag = 1
            })
            
            
           
            
            mainContentWrapper.addArrangedSubview(img)
            
            
            let detailWrapper = VStack(alignment:.fill, distribution:.fill,attributes: {stack in
                let title = Text(text: "",attributes: {label in
                    label.textColor = .darkGray
                    label.tag = 2
                })
                let detail = Text(text: "",attributes: {label in
                    label.tag = 3
                    label.textColor = .darkGray
                   
                })
                
                
                stack.addArrangedSubview(title)
                stack.addArrangedSubview(detail)
                NSLayoutConstraint.activate([
                    
                    title.heightAnchor.constraint(equalToConstant: 40)
                ])
                title.translatesAutoresizingMaskIntoConstraints = false
                
            })
            
            let btn = Button(type: .custom, attributes: { button in
                button.tag = 4
                button.setTitle("", for: .normal)
                button.heightAnchor.constraint(equalToConstant: 40).isActive  = true
                button.translatesAutoresizingMaskIntoConstraints = false
            }, action: action)
            
            mainContentWrapper.addArrangedSubview(detailWrapper)
            
            if(alignment == .vertical){
                
                
               
            }else{
                
                NSLayoutConstraint.activate([
                    img.widthAnchor.constraint(equalToConstant: 80)
                ])
            }
            
            self.addArrangedSubview(mainContentWrapper)
            self.addArrangedSubview(btn)
            
            
        }catch{
            
        }
        
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
