//
//  AddViewController.swift
//  PasswordKeeper
//
//  Created by wangjh on 2019/4/30.
//  Copyright © 2019 jax. All rights reserved.
//

import UIKit

class AddViewController: UITableViewController {
    
    var name: String?
    var domain: String?
    var username: String?
    var password: String?
    var note: String?
    
    let titles = [NSLocalizedString("name", comment: ""),
                  NSLocalizedString("domain", comment: ""),
                  NSLocalizedString("username", comment: ""),
                  NSLocalizedString("password", comment: ""),
                  NSLocalizedString("note", comment: "")]
    let placeholders = [NSLocalizedString("name_placehplder", comment: ""),
                        NSLocalizedString("domain_placehplder", comment: ""),
                        NSLocalizedString("username_placehplder", comment: ""),
                        NSLocalizedString("password_placehplder", comment: ""),
                        NSLocalizedString("note_placehplder", comment: "")]

    init() {
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("add_password", comment: "")

        tableView.register(AddCell.self, forCellReuseIdentifier: NSStringFromClass(AddCell.self))
        tableView.register(AddNoteCell.self, forCellReuseIdentifier: NSStringFromClass(AddNoteCell.self))
        setupItems()
    }
    
    private func setupItems() -> Void {
        let itemCancel = UIBarButtonItem(title: NSLocalizedString("cancel", comment: ""), style: UIBarButtonItem.Style.plain, target: self, action: #selector(didTapCancel))
        let itemDone = UIBarButtonItem(title: NSLocalizedString("done", comment: ""), style: UIBarButtonItem.Style.plain, target: self, action: #selector(didTapDone))
        itemDone.isEnabled = false
        navigationItem.leftBarButtonItem = itemCancel
        navigationItem.rightBarButtonItem = itemDone
    }

}

extension AddViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = titles[indexPath.section]
        let placeholder = placeholders[indexPath.section]
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(AddCell.self)) as! AddCell
            cell.reload(title: title, text: name, placeholder: placeholder)
            cell.textChangedClosure = {[weak self] (text) in
                self?.name = text
                self?.navigationItem.rightBarButtonItem?.isEnabled = text.count > 0
            }
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(AddCell.self)) as! AddCell
            cell.reload(title: title, text: domain, placeholder: placeholder)
            cell.textChangedClosure = {[weak self] (text) in
                self?.domain = text
            }
            return cell
        }
        else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(AddCell.self)) as! AddCell
            cell.reload(title: title, text: username, placeholder: placeholder)
            cell.textChangedClosure = {[weak self] (text) in
                self?.username = text
            }
            return cell
        }
        else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(AddCell.self)) as! AddCell
            cell.reload(title: title, text: password, placeholder: placeholder)
            cell.textChangedClosure = {[weak self] (text) in
                self?.password = text
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(AddNoteCell.self)) as! AddNoteCell
        cell.reload(title: title, text: note, placeholder: placeholder)
        cell.textChangedClosure = {[weak self] (text) in
            self?.note = text
        }
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

extension AddViewController {
    @objc func didTapDone() -> Void {
        view.endEditing(true)
        
        let n = name ?? ""
        if n.isEmpty {
            FZHUD.flash(msg: NSLocalizedString("name_empty", comment: ""))
            return
        }
        if PasswordDB.shared.exist(name: n) {
            FZHUD.flash(msg: NSLocalizedString("name_exist", comment: ""))
            return
        }
        let entry = Password(id: nil, name: n, domain: domain, username: username, password: password, note: note)
        let entryEncrypted = entry.encrypt(key: FZFileManager.readUserPassword())
        if PasswordDB.shared.insert(entry: entryEncrypted) < 0 {
            FZHUD.flash(msg: NSLocalizedString("update_fail", comment: ""))
            return
        }
        FZHUD.flash(msg: NSLocalizedString("update_succeed", comment: ""))
    }
    
    @objc func didTapCancel() -> Void {
        navigationController?.popViewController(animated: true)
    }
}

