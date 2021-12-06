//
//  Extension_String.swift
//  FileManager
//
//  Created by Naveen Chauhan on 16/11/21.
//

import Foundation

extension String {
    var isValidName:Bool {
        var returnVal: Bool = false
        let pattern = "[a-z\\s]*"
        
        
        do{
             let range = NSRange(location: 0, length: self.utf16.count)
            let regx = try NSRegularExpression(pattern: pattern,options: .caseInsensitive)
            let results = regx.matches(in: self, range: range)
            if results.count > 0 {
                returnVal = true
            }else {
                returnVal = false
            }
                    
                
            }catch let error as NSError{
               returnVal = false
            }
        return returnVal
        
    }
    
    var isValidAadhaar:Bool {
        return false
    }
    
    var isValidMobile:Bool {
        return false
    }
    
    var isValidEmail:Bool {
        var returnVal: Bool = false
        let pattern = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        
        do{
             let range = NSRange(location: 0, length: self.utf16.count)
            let regx = try NSRegularExpression(pattern: pattern)
            let results = regx.matches(in: self, range: range)
            if results.count > 0 {
                returnVal = true
            }else {
                returnVal = false
            }
                    
                
            }catch let error as NSError{
               returnVal = false
            }
        return returnVal
    }
    
    
    struct ColorHex {
        static let  body = "#FAFAFAFF"
        static let filesHeader = "#4325D2FF"
        static let healthFolder = "#4AC367FF"
        static let educationFolder = "#FFB54AFF"
        
        static let trashBinTitle = "#3D3D3DFF"
        static let trashBinSubtitle = "#3D3D3DFF"
        static let breadcrumbTextColor = "#5D6373FF"
        static let breadcrumbActiveTextColor = "#2F2F2FFF"
        
        static let mainButton = "#3E0DF5FF"
    }
}
