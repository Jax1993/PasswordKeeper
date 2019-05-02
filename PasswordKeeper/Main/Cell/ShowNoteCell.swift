//
//  ShowNoteCell.swift
//  PasswordKeeper
//
//  Created by wangjh on 2019/5/2.
//  Copyright © 2019 jax. All rights reserved.
//

import UIKit
import SnapKit

class ShowNoteCell: UITableViewCell {
    
    var textChangedClosure: ((String) -> Void)?
    
    var placeholder: String?
    
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 17)
        return lab
    }()
    
    lazy var textView: UITextView = {
        let text = UITextView()
        text.font = UIFont.systemFont(ofSize: 17)
        text.isEditable = false
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLab)
        contentView.addSubview(textView)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() -> Void {
        titleLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(14)
            make.top.equalToSuperview().offset(12)
        }
        textView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
            make.top.equalTo(titleLab.snp.bottom).offset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    func reload(title: String, text: String?) -> Void {
        titleLab.text = title
        textView.text = text
    }
}
