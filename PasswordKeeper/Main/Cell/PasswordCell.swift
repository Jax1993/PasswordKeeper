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
    
    lazy var textLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 17)
        return lab
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(imgView)
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
        textLab.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(20)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-40)
        }
    }
    
    func reload(img: String, text: String) -> Void {
        imgView.image = UIImage(named: img)
        textLab.text = text
    }
}
