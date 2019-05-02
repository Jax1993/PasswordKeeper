//
//  CryptoUtils.swift
//  PasswordKeeper
//
//  Created by wangjh on 2019/5/1.
//  Copyright © 2019 jax. All rights reserved.
//

import UIKit
import CryptoSwift

struct FZCryptoUtils {
    
    /// 默认向量
    static let iv = "0000000000000000"
    
    /// SHA256
    static func encryptUserPassword(password: String) -> Data {
        let data = password.data(using: .utf8)!
        return data.sha256()
    }

    /// 用秘钥对字符串进行加密
    ///
    /// - Parameters:
    ///     - input: 输入字符串
    ///     - key: 秘钥, 根据秘钥长度确定加密算法 AES128, AES256
    /// - Returns: 加密后的十六进制字符串
    static func encrypt(input: String, key: Data) -> String {
        let aes = try! AES(key: key.bytes, blockMode: CBC(iv: iv.bytes))
        let encrypted = try! aes.encrypt(input.bytes)
        let data = Data(encrypted)
        return data.toHexString()
    }
    
    /// 用秘钥对字符串进行解密
    ///
    /// - Parameters:
    ///     - input: 加密字符串的 16 进制字符串形式
    ///     - key: 秘钥, 根据秘钥长度确定加密算法 AES128, AES256
    /// - Returns: 解密后的字符串
    static func decrypt(encrypted: String, key: Data) -> String {
        let data = Data(hex: encrypted)
        let aes = try! AES(key: key.bytes, blockMode: CBC(iv: iv.bytes))
        let decrypted = try! aes.decrypt(data.bytes)
        return String(data: Data(decrypted), encoding: .utf8) ?? ""
    }
}
