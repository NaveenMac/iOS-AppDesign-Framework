//
//  Extension_UserDefaults.swift
//  FileManager
//
//  Created by Naveen Chauhan on 11/11/21.
//

import Foundation

extension UserDefaults {
    
    func valueExists(forKey key:UserDefaultKeys)->Bool {
        return object(forKey: key.rawValue) != nil
    }
    
    func setReadableUsedQuota(value:String) {
        setValue(value, forKey: UserDefaultKeys.usedQuotaInString.rawValue)
    }
    
    func getReadableUsedQuota() -> String? {
        return string(forKey: UserDefaultKeys.usedQuotaInString.rawValue)
    }
    
    func setUsedQuota(value:Int) {
        setValue(value, forKey: UserDefaultKeys.usedQuotaInBytes.rawValue)
    }
    
    func getUsedQuota() -> Int? {
        return integer(forKey: UserDefaultKeys.usedQuotaInBytes.rawValue)
    }
    
    func setReadableAvailableQuota(value:    String) {
        setValue(value, forKey: UserDefaultKeys.availableQuota.rawValue)
    }
    
    func getReadableAvailableQuota() -> String? {
        return string(forKey: UserDefaultKeys.availableQuota.rawValue)
    }
    
    
}
