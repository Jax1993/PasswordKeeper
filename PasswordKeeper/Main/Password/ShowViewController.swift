//
//  ShowViewController.swift
//  PasswordKeeper
//
//  Created by wangjh on 2019/5/2.
//  Copyright © 2019 jax. All rights reserved.
//

import UIKit

class ShowViewController: UITableViewController {
    
    var password: Password
    
    let titles = [NSLocalizedString("name", comment: ""),
                  NSLocalizedString("domain", comment: ""),
                  NSLocalizedString("username", comment: ""),
                  NSLocalizedString("password", comment: ""),
                  NSLocalizedString("note", comment: "")]
    
    init(password: Password) {
        self.password = password
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = password.name
        
        tableView.register(ShowCell.self, forCellReuseIdentifier: NSStringFromClass(ShowCell.self))
        tableView.register(ShowNoteCell.self, forCellReuseIdentifier: NSStringFromClass(ShowNoteCell.self))
    }
}

extension ShowViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = titles[indexPath.section]
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ShowCell.self)) as! ShowCell
            cell.reload(title: title, text: password.name)
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ShowCell.self)) as! ShowCell
            cell.reload(title: title, text: password.domain)
            return cell
        }
        else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ShowCell.self)) as! ShowCell
            cell.reload(title: title, text: password.username)
            return cell
        }
        else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ShowCell.self)) as! ShowCell
            var decrypted = ""
            if let tmp = password.password {
                decrypted = FZCryptoUtils.decrypt(encrypted: tmp, key: FZKeyChain.getPassword())
            }
            cell.reload(title: title, text: decrypted)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ShowNoteCell.self)) as! ShowNoteCell
        var decrypted = ""
        if let tmp = password.note {
            decrypted = FZCryptoUtils.decrypt(encrypted: tmp, key: FZKeyChain.getPassword())
        }
        cell.reload(title: title, text: decrypted)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 4 {
            return 120
        }
        return 48
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
