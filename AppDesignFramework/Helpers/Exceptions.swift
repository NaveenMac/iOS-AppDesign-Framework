//
//  Exceptions.swift
//  FileManager
//
//  Created by Naveen Chauhan on 25/10/21.
//

import Foundation
class Exceptions {
    static let shared = Exceptions()
    
    enum InternalError: String,Error {
        
        case encodingFailed = "Unable to encode parameters"
        case missingURL = "Request url is milling"
        case badRequest = "Bad request we are getting 500"
        case outdated = "The request url is outdated"
        case unableToDecode = "Response is not in correct formate as expected"
        
       
        
    }
    
}
