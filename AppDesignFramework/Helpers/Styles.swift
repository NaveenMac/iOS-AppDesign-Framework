//
//  Style.swift
//  FileManager
//
//  Created by Naveen Chauhan on 06/10/21.
//

import Foundation


struct TextStyle:Codable {
    var text:String?
    var tag:Int?
    var style:[Style]?
    init(tag:Int? = nil,text:String?=nil) {
            
            
            self.tag = tag
        self.text = text
            
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

struct ButtonStyle:Codable {
    var text:String?
    var tag:Int?
    var style:[Style]?
    init(tag:Int? = nil,text:String?=nil) {
            
            
            self.tag = tag
        self.text = text
            
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


struct ScrollBarStyle:Codable {
    
    var itemStyle:[Style]?
    var image:ImageStyle?
    var title:TextStyle?
    var capsule:CapsuleStyle?
    var tag:Int?
    var style:[Style]?
    init( tag:Int? = nil) {
        self.tag = tag
       
            
        }
    enum CodingKeys: String, CodingKey {
       case style = "style"
        case tag = "tag"
        case itemStyle = "itemStyle"
        case image = "image"
        case title = "title"
        case capsule = "capsule"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tag = try values.decodeIfPresent(Int.self, forKey: .tag)
        style = try values.decodeIfPresent([Style].self, forKey:.style)
        itemStyle = try values.decodeIfPresent([Style].self, forKey:.itemStyle)
        image = try values.decodeIfPresent(ImageStyle.self, forKey:.image)
        title = try values.decodeIfPresent(TextStyle.self, forKey:.title)
        title = try values.decodeIfPresent(TextStyle.self, forKey:.title)
        capsule = try values.decodeIfPresent(CapsuleStyle.self, forKey:.capsule)
        
    }
}

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
