//
//  AppDelegate.swift
//  FileManager
//
//  Created by Naveen Chauhan on 05/10/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var appWindow: UIWindow = {
        let w = UIWindow(frame: UIScreen.main.bounds)
        return w
    }()
   
    var filesDirExists = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
      //  self.checkUploadDocumentExistInUserPreference()
        
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        //UINavigationBar.appearance().setBackgroundImage(UIImage(named: "nav-header"), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        UINavigationBar.appearance().tintColor = UIColor.Background.filesHeader
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "ic_blue_back")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "ic_blue_back")
        UINavigationBar.appearance().barTintColor = UIColor.Background.body
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Background.filesHeader]
       
//
        
        
        
        
        // Override point for customization after application launch.
        let homedashboard = DashboardTabBarController()
        
        
       
        self.appWindow.rootViewController = homedashboard
        self.appWindow.makeKeyAndVisible()
        if let flag = try? FileManager.default.checkForFileDirectory() {
           
            filesDirExists = true
        }
        return true
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Determine who sent the URL.
            let sendingAppID = options[.sourceApplication]
            print("source application = \(sendingAppID ?? "Unknown")")

            // Process the URL.
            guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
                let albumPath = components.path,
                let params = components.queryItems else {
                    print("Invalid URL or album path missing")
                    return false
            }

            if let photoImageName = params.first(where: { $0.name == "imgName" })?.value {
                print("imageName = \(photoImageName)")
                return true
            } else {
                print("Photo index missing")
                return false
            }
    }
    
   
}

extension AppDelegate {
    func checkUploadDocumentExistInUserPreference(){
//        let url = FileManager.default.getAppGroupUrl()
//        print(url.path)
        
        if let userDefaults = UserDefaults(suiteName: "group.com.appgroup.ios") {
            
            
            if let recovedUserJsonData = userDefaults.object(forKey: "UploadSharedObject") {
                guard var recovedUserJson = NSKeyedUnarchiver.unarchiveObject(with: recovedUserJsonData as! Data) as? [[String : Any?]] else {return}
                for (index,item) in recovedUserJson.enumerated(){



                    if let name = item["name"] as? String,
                       let directoryPath = FileManager.default.getFilePath(folderName:""),
                       let originalImage = item["itemData"] as? Data,
                       let human_size = item["human_size"] as? String,
                       let thumbNailImg = item["thumbnailImage"] as? Data,
                       let Ext = item["Ext"] as? String,
                       let id = item["id"] as? String{

                        let url = NSURL.fileURL(withPath: directoryPath.appending(name))
                        if !FileManager.default.fileExists(atPath: url.path) {
                            do{ try originalImage.write(to: url, options: .atomic)
                               }catch{}
                              
                        }
                     


                    }
                }
                let myData = NSKeyedArchiver.archivedData(withRootObject: recovedUserJson)
                    UserDefaults(suiteName: "group.com.appgroup.ios")!.set(myData, forKey: "UploadSharedObject")
            }
           
           

            
            
        }
       
       
    }
}

