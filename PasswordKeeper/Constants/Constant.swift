//
//  Constant.swift
//  Jax
//
//  Created by wangjh on 2018/3/30.
//  Copyright © 2018年 Flozy. All rights reserved.
//

import UIKit

struct FZConstant {
    static let DEVICE_LOCK_TIME = 180.0
}

struct FZPath {
    static let PASSWORD_DB = "/Documents/password.db"
    
    static func basePath() -> String {
        return NSHomeDirectory()
    }
    
    static func passwordDBPath() -> String {
        return basePath() + PASSWORD_DB
    }
}

extension Notification.Name {
    public static let BalanceChangedNotification = NSNotification.Name("BalanceChangedNotification")
}
