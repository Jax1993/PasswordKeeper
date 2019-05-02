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
        updateSecurityLock()
        setupLog()
        setupLanguage()
        setupViewControllers()
    }
}

extension AppDelegateController {
    func gotoUnlockIfNeeded() -> Void {
        updateSecurityLock()
        if SecurityUtils.shared.isDeviceLocked {
            setupInputPasswordWindow(input: .unlock)
        }
    }
    
    func updateSecurityLock() -> Void {
        
        if !FileManager.default.fileExists(atPath: FZPath.userPasswordFilePath()) {
            SecurityUtils.shared.isDeviceLocked = false
            return
        }
        let lastLeaveTime = FZUserDefaults.valueForKey(key: .lastLeaveTime)
        guard let last = Double(lastLeaveTime) else {
            SecurityUtils.shared.isDeviceLocked = false
            return
        }
        let date0 = Date(timeIntervalSince1970: last)
        print("date0: " + date0.toDetailString())
        let date1 = Date()
        print("date1: " + date1.toDetailString())
        let timePass = Date().timeIntervalSince1970 - last
        if timePass > FZConstant.DEVICE_LOCK_TIME {
            SecurityUtils.shared.isDeviceLocked = true
        }
    }
    
    func setupViewControllers() -> Void {
        if !FileManager.default.fileExists(atPath: FZPath.userPasswordFilePath()) {
            // 如果没有创建密码 去创建密码
            setupInputPasswordWindow(input: .first)
        } else {
            if SecurityUtils.shared.isDeviceLocked {
                setupInputPasswordWindow(input: .unlock)
            } else {
                setupTabbarRootWindow()
            }
        }
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
    }
    
    func setupInputPasswordWindow(input: InputPasswordEnum) -> Void {
        let vc = InputPasswordViewController(inputEnum: input)
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
