//
//  Extension_UIColor.swift
//  FileManager
//
//  Created by Naveen Chauhan on 10/11/21.
//

import UIKit


extension UIColor {
    
    struct Background {
        static var body : UIColor { return UIColor(hex: String.ColorHex.body) ?? .clear}
        static var healthFolder : UIColor { return UIColor(hex: String.ColorHex.healthFolder) ?? .clear}
        static var educationFolder : UIColor { return UIColor(hex: String.ColorHex.educationFolder) ?? .clear}
        static var filesHeader : UIColor { return UIColor(hex: String.ColorHex.filesHeader) ?? .clear}
        
        
    }
    
    struct Foreground {
        static var breadcrumbTextColor: UIColor { return UIColor(hex: String.ColorHex.breadcrumbTextColor) ?? .clear}
        
        static var breadcrumbActiveTextColor: UIColor {return UIColor(hex: String.ColorHex.breadcrumbActiveTextColor) ?? .clear}
    }
    
    
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
   
   
        
}
