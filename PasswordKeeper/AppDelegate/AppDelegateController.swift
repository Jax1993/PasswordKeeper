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
        setupLog()
        setupLanguage()
        setupViewControllers()
    }
}

extension AppDelegateController {
    func setupViewControllers() -> Void {
        if FileManager.default.fileExists(atPath: FZPath.userPasswordFilePath()) {
           setupTabbarRootWindow()
        } else {
            setupInputPasswordWindow()
        }
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
    }
    
    func setupInputPasswordWindow() -> Void {
        let vc = InputPasswordViewController(inputEnum: .first)
        let navi = FZNavigationController(rootViewController: vc)
        window.rootViewController = navi
    }
    
    func setupTabbarRootWindow() -> Void {
        let tabbar = HomeTabBarViewController()
        window.rootViewController = tabbar
    }
    
    func setupLog() -> Void {
        FZlog.setupLog(path: FZPath.logFilePath())
    }
    
    func setupLanguage() -> Void {
        Bundle.main.onLanguage()
        let language = FZUserDefaults.valueForKey(key: .language)
        if language.isEmpty {
            guard let localeLanguageCode = Locale.current.languageCode else {
                FZUserDefaults.saveValue(value: FZLanguage.english.rawValue, key: .language)
                return
            }
            if (localeLanguageCode.contains("zh")) {
                FZUserDefaults.saveValue(value: FZLanguage.chinese.rawValue, key: .language)
            } else {
                FZUserDefaults.saveValue(value: FZLanguage.english.rawValue, key: .language)
            }
        }
    }
}
