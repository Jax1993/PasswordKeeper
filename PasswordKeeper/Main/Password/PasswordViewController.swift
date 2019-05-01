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
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        tableView.register(PasswordCell.self, forCellReuseIdentifier: NSStringFromClass(PasswordCell.self))
        setupItems()
    }
    
    func loadData() -> Void {
        passwords = PasswordDB.shared.listAll()
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
        cell.reload(password: password)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
