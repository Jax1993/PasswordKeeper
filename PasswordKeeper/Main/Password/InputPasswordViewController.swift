//
//  InputPasswordViewController.swift
//  PasswordKeeper
//
//  Created by wangjh on 2019/5/2.
//  Copyright © 2019 jax. All rights reserved.
//

import UIKit

enum InputPasswordEnum {
    case first
    case again
    case unlock
}

class InputPasswordViewController: UIViewController {
    
    var inputEnum: InputPasswordEnum
    var password: String?

    lazy var textField: UITextField = {
        let text = UITextField()
        text.font = UIFont.systemFont(ofSize: 17)
        text.placeholder = NSLocalizedString("input_password_holder", comment: "")
        text.backgroundColor = UIColor.white
        text.layer.cornerRadius = 20
        text.layer.masksToBounds = true
        text.keyboardType = UIKeyboardType.alphabet
        let view0 = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        text.leftView = view0
        text.leftViewMode = .always
        text.rightView = view1
        text.rightViewMode = .always
        return text
    }()
    
    lazy var doneBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "lock"), for: .normal)
        btn.layer.cornerRadius = 20
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(didTapDone), for: .touchUpInside)
        return btn
    }()
    
    lazy var noticeLab: UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 0
        return lab
    }()
    
    init(inputEnum: InputPasswordEnum) {
        self.inputEnum = inputEnum
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("input_password", comment: "")
        view.backgroundColor = FZColor.whiteColor220
        setupViews()
        makeConstrains()
    }
    
    func noticeByEnum() -> String {
        switch inputEnum {
        case .first:
            return NSLocalizedString("password_notice", comment: "")
        case .again:
            return NSLocalizedString("password_again", comment: "")
        case .unlock:
            return ""
        }
    }
    
    func setupViews() -> Void {
        view.addSubview(textField)
        view.addSubview(doneBtn)
        view.addSubview(noticeLab)
        textField.becomeFirstResponder()
        noticeLab.text = noticeByEnum()
    }
    
    func makeConstrains() -> Void {
        textField.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-80)
            make.size.equalTo(CGSize(width: 240, height: 40))
        }
        doneBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(textField)
            make.right.equalTo(textField)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        noticeLab.snp.makeConstraints { (make) in
            make.left.equalTo(textField)
            make.right.equalTo(textField)
            make.top.equalTo(textField.snp.bottom).offset(20)
        }
    }
}

extension InputPasswordViewController {
    @objc func didTapDone() -> Void {
        view.endEditing(true)
        switch inputEnum {
        case .first:
            handleFirst()
        case .again:
            handleAgain()
        case .unlock:
            handleUnlock()
        }
    }
    
    func handleFirst() -> Void {
        guard let text = textField.text  else {
            FZHUD.flash(msg: NSLocalizedString("input_password_holder", comment: ""))
            return
        }
        if text.count < 6 {
            FZHUD.flash(msg: NSLocalizedString("password_too_short", comment: ""))
            return
        }
        self.password = text
        gotoInputAgain()
    }
    
    func handleAgain() -> Void {
        guard let text = textField.text  else {
            FZHUD.flash(msg: NSLocalizedString("input_password_holder", comment: ""))
            return
        }
        let p = self.password!
        if text != p {
            FZHUD.flash(msg: NSLocalizedString("password_error", comment: ""))
            return
        }
        let sha256 = FZCryptoUtils.encryptUserPassword(password: p)
        FZFileManager.saveUserPassword(data: sha256)
        gotoHome()
    }
    
    func handleUnlock() -> Void {
        guard let text = textField.text  else {
            FZHUD.flash(msg: NSLocalizedString("input_password_holder", comment: ""))
            return
        }
        let sha256 = FZCryptoUtils.encryptUserPassword(password: text)
        let p = FZFileManager.readUserPassword()
        if sha256 != p {
            FZHUD.flash(msg: NSLocalizedString("password_error", comment: ""))
            return
        }
        gotoHome()
    }
    
    func gotoInputAgain() -> Void {
        let vc = InputPasswordViewController(inputEnum: .again)
        vc.password = password
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoHome() -> Void {
        FZHUD.show()
        SecurityUtils.shared.isDeviceLocked = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.5) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.controller.setupTabbarRootWindow()
            FZHUD.hide()
        }
    }
}
