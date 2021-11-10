//
//  ImageStyle.swift
//  FileManager
//
//  Created by Naveen Chauhan on 10/11/21.
//

import Foundation

struct ImageStyle:Codable {
    var url:String?
    var resource:String?
    var tag:Int?
    var style:[Style]?
    init(url: String? = nil,resource: String? = nil,tag:Int? = nil,
             style: [Style]? = nil) {
            
            self.url = url
            self.resource = resource
            self.style = style
        self.tag = tag
            
        }
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case resource = "resource"
        case style = "style"
        case tag = "tag"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        tag = try values.decodeIfPresent(Int.self, forKey: .tag)
        resource = try values.decodeIfPresent(String.self, forKey: .resource)
        style = try values.decodeIfPresent([Style].self, forKey:.style)
        
        
    }
}
