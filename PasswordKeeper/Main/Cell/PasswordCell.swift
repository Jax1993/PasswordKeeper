//
//  PasswordCell.swift
//  PasswordKeeper
//
//  Created by wangjh on 2019/4/30.
//  Copyright © 2019 jax. All rights reserved.
//

import UIKit

class PasswordCell: UITableViewCell {
    
    lazy var imgView: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 17)
        return lab
    }()
    
    lazy var textLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 15)
        return lab
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(imgView)
        contentView.addSubview(titleLab)
        contentView.addSubview(textLab)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() -> Void {
        imgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(14)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 36, height: 36))
        }
        titleLab.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(20)
            make.top.equalToSuperview().offset(10)
        }
        textLab.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(8)
        }
    }
    
    func reload(password: Password) -> Void {
        imgView.image = UIImage(named: "github")
        titleLab.text = password.name
        textLab.text = password.domain
    }
}
