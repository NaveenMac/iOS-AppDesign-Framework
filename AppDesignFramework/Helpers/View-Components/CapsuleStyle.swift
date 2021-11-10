//
//  CapsuleStyle.swift
//  FileManager
//
//  Created by Naveen Chauhan on 10/11/21.
//

import Foundation

struct CapsuleStyle:Codable {
    var title:TextStyle?
    var image:ImageStyle?
    var colors:[String]?
    var tag:Int?
    var order:Int?
    var style:[Style]?
    init(tag:Int? = nil, order:Int? = nil) {
            
            
        self.tag = tag
        self.order = order
            
        }
   
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(TextStyle.self, forKey: .title)
        image = try values.decodeIfPresent(ImageStyle.self, forKey: .image)
        colors = try values.decodeIfPresent([String].self, forKey: .colors)
        tag = try values.decodeIfPresent(Int.self, forKey: .tag)
        style = try values.decodeIfPresent([Style].self, forKey:.style)
        
        
    }
}
