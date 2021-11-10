//
//  StackStyle.swift
//  FileManager
//
//  Created by Naveen Chauhan on 10/11/21.
//

import Foundation

struct StackStyle:Codable {
    var text:String?
    var tag:Int?
    var style:[Style]?
    init(text: String? = nil,tag:Int? = nil,
             style: [Style]? = nil) {
        self.tag = tag
            self.text = text
            self.style = style
            
        }
    enum CodingKeys: String, CodingKey {
        case text = "name"
        case style = "style"
        case tag = "tag"
       
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        tag = try values.decodeIfPresent(Int.self, forKey: .tag)
        style = try values.decodeIfPresent([Style].self, forKey:.style)
        
        
    }
}
