//
//  AppDelegateController.swift
//  PasswordKeeper
//
//  Created by wangjh on 2019/4/28.
//  Copyright © 2019 jax. All rights reserved.
//

import UIKit

class AppDelegateController {

    let window = UIWindow()
    
    func appDidFinishLaunching() -> Void {
        setupViewControllers()
        setupLog()
    }
}

extension AppDelegateController {
    func setupViewControllers() -> Void {
        let tabbar = HomeTabBarViewController()
        window.backgroundColor = UIColor.white
        window.rootViewController = tabbar
        window.makeKeyAndVisible()
    }
    
    func setupLog() -> Void {
        FZlog.setupLog()
    }
}
