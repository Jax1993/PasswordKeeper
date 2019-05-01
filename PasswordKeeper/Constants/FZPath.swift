//
//  FZPath.swift
//  PasswordKeeper
//
//  Created by wangjh on 2019/5/1.
//  Copyright © 2019 jax. All rights reserved.
//

import UIKit

struct FZPath {
    private static let PASSWORD_DB = "/Documents/password.db"
    private static let LOG_FILE = "/Documents/logFile.log"
    private static let USER_PASSWORD_FILE = "/Documents/userPassword"
    
    static func basePath() -> String {
        return NSHomeDirectory()
    }
    
    static func passwordDBPath() -> String {
        return basePath() + PASSWORD_DB
    }
    
    static func logFilePath() -> String {
        return basePath() + LOG_FILE
    }
    
    static func userPasswordFilePath() -> String {
        return basePath() + USER_PASSWORD_FILE
    }
}
