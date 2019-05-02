//
//  ShowCell.swift
//  PasswordKeeper
//
//  Created by wangjh on 2019/5/2.
//  Copyright © 2019 jax. All rights reserved.
//

import UIKit
import SnapKit

class ShowCell: UITableViewCell {
    
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 17)
        return lab
    }()
    
    lazy var textLab: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 17)
        text.textAlignment = .right
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLab)
        contentView.addSubview(textLab)
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
        textLab.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-14)
            make.left.equalTo(titleLab.snp.right).offset(12)
            make.centerY.equalToSuperview()
        }
    }
    
    func reload(title: String, text: String?) -> Void {
        titleLab.text = title
        textLab.text = text
    }
}
