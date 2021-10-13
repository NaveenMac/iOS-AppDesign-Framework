//
//  Switcher.swift
//
//
//  Created by Naveen Chauhan on 02/02/21.
// 
//

import UIKit


public class Switcher: UIStackView {
    init(attributes:(UISwitch)->Void, action:@escaping (UIControl)->Void){
        super.init(frame: CGRect.zero)
        self.axis = .horizontal
        self.alignment = .fill
        self.distribution = .fill
        
        let switcher = UISwitch()
        switcher.addAction1(for: .valueChanged, action)
        attributes(switcher)
        self.addArrangedSubview(switcher)
        
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
