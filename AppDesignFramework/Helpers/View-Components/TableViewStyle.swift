//
//  TableViewStyle.swift
//  FileManager
//
//  Created by Naveen Chauhan on 10/11/21.
//

import Foundation

struct TableViewStyle:Codable {
    
    var itemStyle:[Style]?
    var image:ImageStyle?
    var title:TextStyle?
    var subtitle:TextStyle?
    var tag:Int?
    var style:[Style]?
    init(tag:Int? = nil) {
        self.tag = tag
        
            
        }
    enum CodingKeys: String, CodingKey {
       case style = "style"
        case tag = "tag"
        case itemStyle = "itemStyle"
        case image = "image"
        case title = "title"
        case subtitle = "subtitle"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tag = try values.decodeIfPresent(Int.self, forKey: .tag)
        style = try values.decodeIfPresent([Style].self, forKey:.style)
        itemStyle = try values.decodeIfPresent([Style].self, forKey:.itemStyle)
        image = try values.decodeIfPresent(ImageStyle.self, forKey:.image)
        title = try values.decodeIfPresent(TextStyle.self, forKey:.title)
        subtitle = try values.decodeIfPresent(TextStyle.self, forKey:.subtitle)
        
    }
}
