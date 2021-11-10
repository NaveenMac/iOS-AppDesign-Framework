//
//  Style.swift
//  FileManager
//
//  Created by Naveen Chauhan on 10/11/21.
//

import Foundation

struct Style:Codable {
    var attr:String?
    var value:String?
    init(attr:String, value:String){
        self.attr = attr
        self.value = value
    }
    enum CodingKeys: String, CodingKey {
        case attr = "attr"
        case value = "value"
       
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        attr = try values.decodeIfPresent(String.self, forKey: .attr)
        value = try values.decodeIfPresent(String.self, forKey:.value)
        
        
    }
}
