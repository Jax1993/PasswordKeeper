//
//  FZHUD.swift
//  PasswordKeeper
//
//  Created by wangjh on 2019/5/1.
//  Copyright © 2019 jax. All rights reserved.
//

import UIKit
import PKHUD

class FZHUD {
    public static func show() -> Void {
        HUD.show(.progress)
    }
    
    public static func show(msg: String) -> Void {
        HUD.show(.label(msg))
    }
    
    public static func hide() -> Void {
        HUD.hide()
    }
    
    public static func flash(msg: String) -> Void {
        HUD.flash(.label(msg), delay: 1.25, completion:nil)
    }
}
