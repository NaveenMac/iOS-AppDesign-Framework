//
//  UserDefaultsHelper.swift
//  FileManager
//
//  Created by Naveen Chauhan on 22/10/21.
//

import Foundation

enum UserDefaultKeys: String, CaseIterable {
    case usedQuotaInString
    case usedQuotaInBytes
    case availableQuota
}
final class UserDefaultsHelper {
    static func setData<T>(value:T, key:UserDefaultKeys){
        let defaults = UserDefaults.standard
        defaults.setValue(value, forKey: key.rawValue)
    }
    
    static func getValue<T>(type:T.Type,forKey:UserDefaultKeys)->T?{
        let defaults = UserDefaults.standard
        let value = defaults.object(forKey: forKey.rawValue) as? T
        return value
     }
    
    static func removeData(forKey:UserDefaultKeys){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: forKey.rawValue)
    }
}

//func removeAllObjects(){
//   _ =  UserDefaultKeys.allCases.map({
//        UserDefaultsHelper.removeData(forKey: $0)
//    })
//}
