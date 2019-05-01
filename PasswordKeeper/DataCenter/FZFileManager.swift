//
//  FZFileManager.swift
//  PasswordKeeper
//
//  Created by wangjh on 2019/5/1.
//  Copyright © 2019 jax. All rights reserved.
//

import UIKit

class FZFileManager {
    class func saveUserPassword(data: Data) -> Void {
        let url = URL(fileURLWithPath: FZPath.userPasswordFilePath())
        try! data.write(to: url)
    }

    class func readUserPassword() -> Data {
        let url = URL(fileURLWithPath: FZPath.userPasswordFilePath())
        return try! Data(contentsOf: url)
    }
}
