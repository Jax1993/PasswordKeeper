//
//  AddCell.swift
//  PasswordKeeper
//
//  Created by wangjh on 2019/4/30.
//  Copyright © 2019 jax. All rights reserved.
//

import UIKit
import SnapKit

class AddCell: UITableViewCell {
    
    var textChangedClosure: ((String) -> Void)?
    
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 17)
        return lab
    }()
    
    lazy var textField: UITextField = {
        let text = UITextField()
        text.font = UIFont.systemFont(ofSize: 17)
        text.delegate = self
        text.textAlignment = .right
        return text
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLab)
        contentView.addSubview(textField)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() -> Void {
        titleLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(14)
            make.width.equalTo(90)
            make.centerY.equalToSuperview()
        }
        textField.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-14)
            make.left.equalTo(titleLab.snp.right).offset(12)
            make.centerY.equalToSuperview()
        }
    }
    
    func reload(title: String, text: String?, placeholder: String?) -> Void {
        titleLab.text = title
        textField.text = text
        textField.placeholder = placeholder
    }

}

extension AddCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let closure = textChangedClosure {
            let text = textField.text ?? ""
            closure(text)
        }
    }
}
