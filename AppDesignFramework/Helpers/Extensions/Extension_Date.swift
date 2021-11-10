//
//  Extension_Date.swift
//  FileManager
//
//  Created by Naveen Chauhan on 10/11/21.
//

import Foundation

extension Data{
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
       if let data = string.data(using: encoding) {
        append(data)
    }
  }
}
