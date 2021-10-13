//
//  TextField.swift
//
//
//  Created by Naveen Chauhan on 02/02/21.
//  
//

import UIKit


public class TextField: UITextField {
    let formRow:UIStackView = {
        let formRow = VStack(alignment: .fill, spacing: 5, attributes: { stack in
            
        })
        return formRow
    }()
    init(imageName:String?=nil,title:String?=nil, text:String? = nil, attributes:((UITextField)->Void)? = nil){
        super.init(frame: CGRect.zero)
        
        if let lbl = title {
            let label = Text(text: lbl)
            formRow.addArrangedSubview(label)
        }
        
        
        let field = UITextField()
        if let val = text {
            field.text = val
        }
        
        field.borderStyle = .none
        
        if let name = imageName {
            if let img = UIImage(named: name) {
                field.leftViewMode = .always
                field.leftView = UIImageView(image: img)
            }
            
        }
        
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: field.frame.height - 1, width: field.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.darkGray.cgColor
        field.borderStyle = UITextField.BorderStyle.none
        field.layer.addSublayer(bottomLine)

        
        
        
        if let block = attributes {
            block(field)
        }
        formRow.addArrangedSubview(field)
    }
    
    init(imageName:String?=nil,title:String?=nil, text:String? = nil, attributes:((PaddedTextField)->Void)? = nil){
        super.init(frame: CGRect.zero)
        
        if let lbl = title {
            let label = Text(text: lbl)
            formRow.addArrangedSubview(label)
        }
        
        
        let field = PaddedTextField()
        if let val = text {
            field.text = val
        }
        
        field.borderStyle = .none
        
        if let name = imageName {
            if let img = UIImage(named: name) {
                field.leftViewMode = .always
                field.leftView = UIImageView(image: img)
            }
            
        }
        
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: field.frame.height - 1, width: field.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.darkGray.cgColor
        field.borderStyle = UITextField.BorderStyle.none
        field.layer.addSublayer(bottomLine)

        
        
        
        if let block = attributes {
            block(field)
        }
        formRow.addArrangedSubview(field)
    }
    
    
    func getFormRow()->UIStackView{
        return self.formRow
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
