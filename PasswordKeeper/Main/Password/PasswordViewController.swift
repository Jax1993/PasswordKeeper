//
//  PasswordViewController.swift
//  PasswordKeeper
//
//  Created by wangjh on 2019/4/28.
//  Copyright © 2019 jax. All rights reserved.
//

import UIKit

class PasswordViewController: UITableViewController {

    var passwords: [Password] = []
    
    init() {
        let p0 = Password(domain: "github.com", username: "wangjh", password: "123123", note: "")
        let p1 = Password(domain: "google.com", username: "wangjh", password: "123123", note: "")
        let p2 = Password(domain: "bilibili.com", username: "wangjh", password: "123123", note: "")
        let p3 = Password(domain: "twitter.com", username: "wangjh", password: "123123", note: "")
        passwords.append(contentsOf: [p0,p1,p2,p3])
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(PasswordCell.self, forCellReuseIdentifier: NSStringFromClass(PasswordCell.self))
        setupItems()
    }
    
    private func setupItems() -> Void {
        let item = UIBarButtonItem(image: UIImage(named: "add"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(didTapAdd))
        navigationItem.rightBarButtonItem = item
    }

}

extension PasswordViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return passwords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PasswordCell.self)) as! PasswordCell
        let password = passwords[indexPath.section]
        cell.reload(img: "github", text: password.domain)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
}

extension PasswordViewController {
    @objc func didTapAdd() -> Void {
        let vc = AddViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
