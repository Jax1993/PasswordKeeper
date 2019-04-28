//
//  FZUserDefaults.swift
//  Jax
//
//  Created by wangjh on 2018/6/13.
//  Copyright © 2018年 Flozy. All rights reserved.
//

import UIKit

enum FZDefaultsKey: String {
    case language = "fz_defaults_key_language"
    case currency = "fz_defaults_key_currency"
    case isTurnOnFingureprint = "fz_defaults_key_fingureprint"
    case lastLeaveTime = "fz_defaults_key_last_leave_time"
}

class FZUserDefaults {
    
    class func valueForKey(key: FZDefaultsKey) -> String {
        guard let value = UserDefaults.standard.string(forKey: key.rawValue) else { return "" }
        return value
    }
    
    class func saveValue(value: String, key: FZDefaultsKey) -> Void {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
}
