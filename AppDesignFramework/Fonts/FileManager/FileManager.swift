//
//  FileManager.swift
//  FileManager
//
//  Created by Naveen Chauhan on 27/10/21.
//

import Foundation
extension FileManager {
    func getAppGroupUrl()->URL{
        let directoryPath = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Constants.APP_GROUP)!
        return directoryPath
    }
    
    func getDriveFilesPath()->URL?{
        let url = self.getAppGroupUrl()
        let dirUrl = url.appendingPathComponent("FilesDrive")
        if !FileManager.default.fileExists(atPath: dirUrl.path) {
           do {
            try FileManager.default.createDirectory(atPath: dirUrl.path, withIntermediateDirectories: true, attributes: nil)
             } catch {
               print(error)
               return nil
               }
           }
        return dirUrl
    }
    
    func getDriveFilePath(name:String,extention:String)->String?{
        var fileUrl = self.getDriveFilesPath()
        fileUrl = fileUrl?.appendingPathComponent(name).appendingPathExtension(extention)
        return fileUrl?.path
    }
    
    func getDriveFileThumbPath(name:String)->String?{
        let fileExt = NSString(string: name).pathExtension as NSString
        let fileName = NSString(string: name).deletingPathExtension
        var fileUrl = self.getDriveFilesPath()
        fileUrl = fileUrl?.appendingPathComponent("\(fileName)_thumb.\(fileExt)")
        return fileUrl?.path
    }
    
    func removeFile(at path:String){
        
    }
    
    func saveFile(at path:String){
        
    }
}
