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
    func getFormattedDate(format:String)->String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: self)
    }
    
    static func getFormattedDate(value:String, format:String)->Date?{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        
        let date = dateFormat.date(from: value)
        return date
    }
    
    static func getDateStrFromOldFormat(input:String,oldFormat:String, newFormat:String)->String?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = oldFormat
        let dateObj = dateFormatter.date(from: input)
        dateFormatter.dateFormat = newFormat
        guard dateObj != nil else {
            return nil
        }
        let finalDateStr:String = dateFormatter.string(from: dateObj!)
        return finalDateStr
    }
    
    
}
