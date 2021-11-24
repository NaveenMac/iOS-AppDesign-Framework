//
//  Extension_Date.swift
//  FileManager
//
//  Created by Naveen Chauhan on 10/11/21.
//

import Foundation

extension Date{
     func convertDateToString()-> String{
         let df = DateFormatter()
         df.dateFormat = "YYYY-MM-dd"
        let now = df.string(from: self)
        return now
     }
}
