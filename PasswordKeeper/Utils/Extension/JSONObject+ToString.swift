//
//  JSONObject+ToString.swift
//  Jax
//
//  Created by wangjh on 2018/8/16.
//  Copyright © 2018年 Flozy. All rights reserved.
//

import UIKit

extension Dictionary {
    func toJSONString() -> String? {
        if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
            if let s = String(data: data, encoding: String.Encoding.utf8) {
                return s
            }
        }
        return nil
    }
}

extension Array {
    func toJSONString() -> String? {
        if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
            if let s = String(data: data, encoding: String.Encoding.utf8) {
                return s
            }
        }
        return nil
    }
}
