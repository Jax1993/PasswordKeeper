//
//  Password.swift
//  PasswordKeeper
//
//  Created by wangjh on 2019/4/30.
//  Copyright © 2019 jax. All rights reserved.
//

import UIKit

struct Password: Codable {
    let id: Int?
    let name: String
    let domain: String?
    let username: String?
    let password: String?
    let note: String?
}

extension Password {
    func encrypt(key: Data) -> Password {
        var passwordEncypted = ""
        if let p = self.password {
            passwordEncypted = FZCryptoUtils.encrypt(input: p, key: key)
        }
        var noteEncypted = ""
        if let n = self.note {
            noteEncypted = FZCryptoUtils.encrypt(input: n, key: key)
        }
        let entry = Password(id: self.id, name: self.name, domain: self.domain, username: self.username, password: passwordEncypted, note: noteEncypted)
        return entry
    }
}
