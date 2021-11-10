//
//  AppFileManager.swift
//  FileManager
//
//  Created by Naveen Chauhan on 25/10/21.
//

import Foundation
class  AppFileManager : NSObject {
    static let shared = AppFileManager()
    
   
    func getRelativePath(folderName : String) -> String?{
        
        let directoryPath = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Constants.APP_GROUP)!
        var pathString = ""
        if folderName.isEmpty {
         pathString = directoryPath.path.appending("/Drive/")
        }else{
          pathString = directoryPath.path.appending("/Drive/\(folderName)").appending("/")
        }
        
         if !FileManager.default.fileExists(atPath: pathString) {
            do {
                try FileManager.default.createDirectory(atPath: pathString, withIntermediateDirectories: true, attributes: nil)
              } catch {
                print(error)
                return nil
                }
            }
        return pathString
        
    }
    
    func getDirectoryPath(folderName : String) -> String?{
        let directoryPath = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Constants.APP_GROUP)!
        var pathString = ""
        if folderName.isEmpty {
         pathString = directoryPath.path.appending("/")
        }else{
          pathString = directoryPath.path.appending("/\(folderName)").appending("/")
        }
        
         if !FileManager.default.fileExists(atPath: pathString) {
            do {
                try FileManager.default.createDirectory(atPath: pathString, withIntermediateDirectories: true, attributes: nil)
              } catch {
                print(error)
                return nil
                }
            }
        return pathString
      }
    
}
