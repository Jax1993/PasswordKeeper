//
//  Date+Extension.swift
//  Jax
//
//  Created by wangjh on 2018/6/5.
//  Copyright © 2018年 Flozy. All rights reserved.
//

import UIKit

extension Date {
    
    func toString(format: String) -> String? {
        let formater = DateFormatter()
        formater.dateFormat = format
        return formater.string(from: self)
    }
    
    func toString() -> String? {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        return formater.string(from: self)
    }
    
    func toDetailString() -> String? {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return formater.string(from: self)
    }
    
    static func dateWith(isoDate: String) -> Date {
        //let isoDate = "2016-04-14T10:44:00.000"
        var iso = isoDate
        iso = String(iso.dropLast(4))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: iso)!
        return date
    }
    
}
