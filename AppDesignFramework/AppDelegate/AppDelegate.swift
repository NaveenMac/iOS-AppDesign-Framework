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
   

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        //UINavigationBar.appearance().setBackgroundImage(UIImage(named: "nav-header"), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        UINavigationBar.appearance().tintColor = UIColor.Background.filesHeader
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "ic_blue_back")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "ic_blue_back")
        UINavigationBar.appearance().barTintColor = UIColor.Background.body
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Background.filesHeader]
       
//
        
        
        
        
        // Override point for customization after application launch.
        let homedashboard = DashboardTabBarController()
        
        
       
        self.appWindow.rootViewController = homedashboard
        self.appWindow.makeKeyAndVisible()
        return true
    }
    
    
   
}

