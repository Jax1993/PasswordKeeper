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
        FZFileManager.saveUserPassword(data: FZCryptoUtils.encryptUserPassword(password: "qwerqwer"))
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
