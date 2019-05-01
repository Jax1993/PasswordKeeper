//
//  PasswordKeeperTests.swift
//  PasswordKeeperTests
//
//  Created by wangjh on 2019/4/27.
//  Copyright © 2019 jax. All rights reserved.
//

import XCTest
@testable import PasswordKeeper

class PasswordKeeperTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSHA256() -> Void {
        let password = "user_password"
        let keyData = FZCryptoUtils.encryptUserPassword(password: password)
        assert(keyData.toHexString() == "4234a9cea21fa911110cf36e96cd887049543ca31e7c95e04028290bde1db1e0", "密码哈希错误")
    }
    
    func testEncrypt() -> Void {
        let input = "github_password"
        let password = "4234a9cea21fa911110cf36e96cd887049543ca31e7c95e04028290bde1db1e0"
        let keyData = Data(hex: password)
        let encrypted = FZCryptoUtils.encrypt(input: input, key: keyData)
        assert(encrypted == "9ffe2a9e853f370df2ed5bbc3eae2bf9", "加密错误")
    }

    func testDecrypt() {
        let password = "user_password"
        let input = "github_password"
        let keyData = FZCryptoUtils.encryptUserPassword(password: password)
        let encrypted = FZCryptoUtils.encrypt(input: input, key: keyData)
        let decrypted = FZCryptoUtils.decrypt(encrypted: encrypted, key: keyData)
        assert(decrypted == input, "解密错误")
    }
    
    func testFileData() -> Void {
        let password = "user_password"
        let keyData = FZCryptoUtils.encryptUserPassword(password: password)
        FZFileManager.saveUserPassword(data: keyData)
        let data = FZFileManager.readUserPassword()
        assert(data == keyData, "文件读写错误")
        
    }

}
