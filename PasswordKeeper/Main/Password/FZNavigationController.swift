//
//  FZNavigationController.swift
//  PasswordKeeper
//
//  Created by wangjh on 2019/4/28.
//  Copyright © 2019 jax. All rights reserved.
//

import UIKit

class FZNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.setBackgroundImage(UIImage.image(with: FZColor.themeBlackColor), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

}
