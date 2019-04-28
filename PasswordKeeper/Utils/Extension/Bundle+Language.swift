//
//  Bundle+Language.swift
//  Jax
//
//  Created by wangjh on 2018/6/13.
//  Copyright © 2018年 Flozy. All rights reserved.
//

import UIKit

enum FZLanguage : String {
    case english = "en"
    case chinese = "zh-Hans"
}

class BundleEx: Bundle {
    
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if let bundle = Bundle.getLanguageBundel() {
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        } else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
    }
}

extension Bundle {
    
    private static var onLanguageDispatchOnce: ()-> Void = {
        object_setClass(Bundle.main, BundleEx.self)
    }
    
    func onLanguage() {
        Bundle.onLanguageDispatchOnce()
    }
    
    class func getLanguageBundel() -> Bundle? {
        let language = FZUserDefaults.valueForKey(key: .language)
        let languageBundlePath = Bundle.main.path(forResource: language, ofType: "lproj")
        guard languageBundlePath != nil else {
            return nil
        }
        let languageBundle = Bundle.init(path: languageBundlePath!)
        guard languageBundle != nil else {
            return nil
        }
        return languageBundle!
        
    }
}
