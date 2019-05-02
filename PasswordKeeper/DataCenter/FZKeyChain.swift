
//
//  FZKeyChain.swift
//  PasswordKeeper
//
//  Created by wangjh on 2019/5/2.
//  Copyright © 2019 jax. All rights reserved.
//

import UIKit
import KeychainAccess

class FZKeyChain {
    static let KEY_CHAIN_SERVICE = "me.jax.password"
    static let PASSWORD_KEY = "password_key"
    
    class func existPassword() -> Bool {
        let keychain = getKeychain()
        if let p = try! keychain.getData(PASSWORD_KEY), !p.isEmpty {
            return true
        }
        return false
    }
    
    class func getPassword() -> Data {
        let keychain = getKeychain()
        return try! keychain.getData(PASSWORD_KEY)!
    }
    
    class func setPassword(data: Data) -> Void {
        let keychain = getKeychain()
        try? keychain.set(data, key: PASSWORD_KEY)
    }
    
    private class func getKeychain() -> Keychain {
        return Keychain(service: KEY_CHAIN_SERVICE)
    }

}
