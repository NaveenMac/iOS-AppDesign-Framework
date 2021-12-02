//
//  OptionFieldStyle.swift
//  UserNominees
//
//  Created by Naveen Chauhan on 02/12/21.
//

import Foundation

struct RadioFieldStyle:Codable {
    var title:TextStyle?
    var option:TextStyle?
    var tag:Int?
    var style:[Style]?
    init(tag:Int? = nil) {
            
            
            self.tag = tag
        
            
        }
  
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(TextStyle.self, forKey: .title)
        option = try values.decodeIfPresent(TextStyle.self, forKey: .option)
        tag = try values.decodeIfPresent(Int.self, forKey: .tag)
        style = try values.decodeIfPresent([Style].self, forKey:.style)
        
        
    }
}
