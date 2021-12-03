//
//  OptionFieldStyle.swift
//  UserNominees
//
//  Created by Naveen Chauhan on 02/12/21.
//

import UIKit

struct RadioFieldStyle:Codable {
    var title:TextStyle?
    var option:TextStyle?
    var list:[String]?
    var tag:Int?
    var style:[Style]?
    init(tag:Int? = nil) {
            
            
            self.tag = tag
        
            
        }
  
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(TextStyle.self, forKey: .title)
        option = try values.decodeIfPresent(TextStyle.self, forKey: .option)
        list = try values.decodeIfPresent([String].self, forKey: .list)
        tag = try values.decodeIfPresent(Int.self, forKey: .tag)
        style = try values.decodeIfPresent([Style].self, forKey:.style)
        
        
    }
    
    static func getRadioButtonGroup(tag:Int, style:RadioFieldStyle)->UIStackView {
        let stack = UIView.VStack(spacing: 5, distribution: .fillProportionally)
        stack.tag = tag
        let title = PaddedLabel()
        title.font = UIFont.systemFont(ofSize: 12.76)
        title.textColor = UIColor.TextField.activeText
        
        if let text = style.title?.text {
            title.text = text
           
        }
        stack.addArrangedSubview(title)
        
        if let data = style.list {
            let group = UIView.HStack(spacing: 20, distribution: .fillProportionally)
            group.translatesAutoresizingMaskIntoConstraints = false
            group.isLayoutMarginsRelativeArrangement = true
           
            
            var index = tag
            for label in data {
                index = index + 1
                let button = UIButton()
                button.tag = index
                
                button.setTitle(label, for: .normal)
                    button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -2, bottom: 0, right:8)
//                    button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 10)
                
                button.setTitleColor(UIColor.TextField.activeText, for: .normal)
                button.setImage(UIImage(named: "nominee_unselected_radio"), for: .normal)
                button.setImage(UIImage(named: "nominee_selected_radio"), for: .selected)
                button.isSelected = false
                
                
                
               
                group.addArrangedSubview(button)
            }
            
            stack.addArrangedSubview(group)
        }
        
        if let style = style.style {
            UIView.setStackViewStyle(stack: stack, style: style)
        }
        return stack
        
    }
}
