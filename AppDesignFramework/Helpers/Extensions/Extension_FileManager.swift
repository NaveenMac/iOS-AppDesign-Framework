//
//  Extension_FileManager.swift
//  FileManager
//
//  Created by Naveen Chauhan on 14/11/21.
//

import Foundation
extension FileManager {
    func getAppGroupUrl()->URL{
        let directoryPath = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Constants.APP_GROUP)!
        return directoryPath
    }
    
     func checkForFileDirectory()  throws ->Bool{
        let defaultManager = FileManager.default
        if let filesDirUrl = AppStorage.files.directoryURL {
            if !defaultManager.fileExists(atPath: filesDirUrl.path){
                try defaultManager.createDirectory(atPath: filesDirUrl.path, withIntermediateDirectories: false, attributes: nil)
                return true
            }else{
                return true
            }
        }
        return false
        
    }
}
