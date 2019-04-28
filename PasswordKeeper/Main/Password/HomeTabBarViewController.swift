//
//  HomeTabBarViewController.swift
//  PasswordKeeper
//
//  Created by wangjh on 2019/4/28.
//  Copyright © 2019 jax. All rights reserved.
//

import UIKit

class HomeTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupChild()
    }
    
    private func setupChild() -> Void {
        let vc0 = PasswordViewController()
        let title0 = NSLocalizedString("password", comment: "")
        vc0.title = title0
        let image0 = UIImage(named: "tab_password")
        let imageSelected0 = UIImage(named: "tab_password_gray")
        vc0.tabBarItem = UITabBarItem(title: title0, image: image0, selectedImage: imageSelected0)
        let navi0 = FZNavigationController(rootViewController: vc0)
        
        let vc1 = SettingViewController()
        let title1 = NSLocalizedString("setting", comment: "")
        vc1.title = title1
        let image1 = UIImage(named: "tab_setting")
        let imageSelected1 = UIImage(named: "tab_setting_gray")
        vc1.tabBarItem = UITabBarItem(title: title1, image: image1, selectedImage: imageSelected1)
        let navi1 = FZNavigationController(rootViewController: vc1)
       
        
        let children = [navi0, navi1]
        setViewControllers(children, animated: false)
        tabBar.tintColor = FZColor.themeBlueColor
    }

}
