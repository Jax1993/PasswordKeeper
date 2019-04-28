//
//  UITextFiled+Extenstion.swift
//  Jax
//
//  Created by wangjh on 2018/9/21.
//  Copyright © 2018年 Flozy. All rights reserved.
//

import UIKit

extension UITextField {
    func setupToolBar() -> Void {
        self.inputAccessoryView = fzToolBar()
    }
    
    private func fzToolBar() -> UIToolbar {
        let w = UIScreen.main.bounds.width
        let bar = UIToolbar(frame: CGRect(x: 0, y: 0, width: w, height: 44))
        let whiteItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        whiteItem.width = w - 60
        let item = UIBarButtonItem(image: UIImage(named: "down_white"), style: .plain, target: self, action: #selector(didTapToolBarDownBtn))
        bar.items = [whiteItem, item]
        return bar
    }
    
    @objc private func didTapToolBarDownBtn() -> Void {
        self.resignFirstResponder()
    }
}
