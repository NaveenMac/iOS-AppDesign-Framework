//
//  TextFieldStyle.swift
//  UserNominees
//
//  Created by Naveen Chauhan on 02/12/21.
//


import Foundation

struct TextFieldStyle:Codable {
    var title:TextStyle?
    var text:String?
    var hint:String?
    var leadingIcon:String?
    var trailingIcon:String?
    var list:[String]?
    var tag:Int?
    var style:[Style]?
    init(tag:Int? = nil) {
            
            
            self.tag = tag
        
            
        }
  
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(TextStyle.self, forKey: .title)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        leadingIcon = try values.decodeIfPresent(String.self, forKey: .leadingIcon)
        trailingIcon = try values.decodeIfPresent(String.self, forKey: .trailingIcon)
        list = try values.decodeIfPresent([String].self, forKey: .list)
        hint = try values.decodeIfPresent(String.self, forKey: .hint)
        tag = try values.decodeIfPresent(Int.self, forKey: .tag)
        style = try values.decodeIfPresent([Style].self, forKey:.style)
     }
}
