//
//  Struct_RowStyle.swift
//  FileManager
//
//  Created by Naveen Chauhan on 10/11/21.
//

import Foundation

struct RowStyle:Codable {
    var text:String?
    var type:String?
    var index:Int?
    var section:Int?
    init(section:Int? = nil,index:Int? = nil,text:String?=nil,type:String? = nil) {
            
            
            self.index = index
        self.text = text
        self.section = section
        self.type = type
            
        }
    enum CodingKeys: String, CodingKey {
        case text = "name"
        case section = "section"
       case index = "index"
        case type = "type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        index = try values.decodeIfPresent(Int.self, forKey: .index)
        section = try values.decodeIfPresent(Int.self, forKey:.section)
        type = try values.decodeIfPresent(String.self, forKey:.type)
        
        
    }
}
