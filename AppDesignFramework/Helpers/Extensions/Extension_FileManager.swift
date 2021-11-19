//
//  Extension_FileManager.swift
//  FileManager
//
//  Created by Naveen Chauhan on 14/11/21.
//

import Foundation
extension FileManager {
    enum App: Int {
       case documents
       case library
       case cache
       case tmp
       case applicationSupport
       case files
       
       // Return the base URL for the selected directory.
       var directoryURL: URL? {
          // Find the path for the selected directory.
          let baseDirectory: URL?
          let fileManager = FileManager.default
          switch self {
          case .documents:
             baseDirectory = try?
                fileManager.url(for: .documentDirectory,
                                in: .userDomainMask,
                                appropriateFor: nil,
                                create: false)
          case .library:
             baseDirectory = try?
                fileManager.url(for: .libraryDirectory,
                                in: .userDomainMask,
                                appropriateFor: nil,
                                create: false)
          case .cache:
             baseDirectory = try?
                fileManager.url(for: .cachesDirectory,
                                in: .userDomainMask,
                                appropriateFor: nil,
                                create: false)
          case .tmp:
             baseDirectory = fileManager.temporaryDirectory
             
          case .applicationSupport:
             baseDirectory = try?
                fileManager.url(for: .applicationSupportDirectory,
                                in: .userDomainMask,
                                appropriateFor: nil,
                                create: false)
          case .files:
             baseDirectory = try?
                fileManager.url(for: .libraryDirectory,
                                in: .userDomainMask,
                                appropriateFor: nil,
                                create: false).appendingPathComponent(Constants.FILE_DIR)
            
          }
          
          return baseDirectory
       }
       
       // Create a file in the selected App directory.
       func createFile (_ filename: String,
                        contents: Data?,
                        attributes: [FileAttributeKey: Any]? = nil) -> Bool {
          // Set the base directory URL for the chosen app directory.
          guard let baseDirectory = self.directoryURL else {
             // The File Manager couldn't find the directory or create the file.
             print("Unable to locate the directory: \(self.rawValue).")
             return false
          }
          
          let fileURL = baseDirectory.appendingPathComponent(filename)
          
          return FileManager.default.createFile(atPath: fileURL.path,
                                                contents: contents,
                                                attributes: attributes)
       }
        
        func getFileUrl(filename:String)->URL?{
            guard let baseDirectory = self.directoryURL else {
               // The File Manager couldn't find the directory or create the file.
               print("Unable to locate the directory: \(self.rawValue).")
               return nil
            }
            
            let fileURL = baseDirectory.appendingPathComponent(filename)
            return fileURL
        }
        
        func fileExists(filename:String)->Bool{
            guard let baseDirectory = self.directoryURL else {
               // The File Manager couldn't find the directory or create the file.
               print("Unable to locate the directory: \(self.rawValue).")
                return false
            }
            
            let fileURL = baseDirectory.appendingPathComponent(filename)
            return FileManager.default.fileExists(atPath: fileURL.path)
        }
    }

    
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
    
    func isFileExistsInDrive(name:String)->Bool{
        guard let fileUrl = AppStorage.files.getFileUrl(filename: name) else {
            
            return false
        }
        if AppStorage.files.fileExists(filename: name) {
           
            
            return true
        }else{
           return false
        }
    }
}
