//
//  PasswordDB.swift
//  PasswordKeeper
//
//  Created by wangjh on 2019/5/1.
//  Copyright © 2019 jax. All rights reserved.
//

import UIKit
import SQLite

class PasswordDB {
    let defaultDBPath = FZPath.passwordDBPath()
    var db: Connection!
    let tableName = "password"
    
    let tid = Expression<Int>("id")
    let tname = Expression<String>("name")
    let tdomain = Expression<String>("domain")
    let tusername = Expression<String>("username")
    let tpasswrod = Expression<String>("password")
    let tnote = Expression<String>("note")
    
    static let shared = PasswordDB()
    private init() {
        do {
            db = try Connection(defaultDBPath)
            FZlog.debug("defaultDBPath: " + defaultDBPath)
            createTable()
        } catch {
            FZlog.debug("db Connection error: \(error)")
        }
    }
    
    func insert(entry: Password) -> Int {
        let table = Table(tableName)
        if exist(entry: entry) {
            return -1
        }
        do {
            let insert = try table.insert(entry)
            let res = try db.run(insert)
            return Int(res)
        } catch let error {
            FZlog.debug("insert error: \(error)")
        }
        return -1
    }
    
    func update(entry: Password) -> Int {
        let table = Table(tableName)
        let query = table.filter(tname == entry.name)
        do {
            let update = try query.update(entry)
            return try db.run(update)
        } catch let error {
            FZlog.error("update error: \(error)")
        }
        return -1
    }
    
    func exist(entry: Password) -> Bool {
        let table = Table(tableName)
        let query = table.filter(tname == entry.name)
        do {
            for _ in try db.prepare(query) {
                return true
            }
        } catch {
            FZlog.error(error)
        }
        return false
    }
    
    func exist(name: String) -> Bool {
        let table = Table(tableName)
        let query = table.filter(tname == name)
        do {
            for _ in try db.prepare(query) {
                return true
            }
        } catch {
            FZlog.error(error)
        }
        return false
    }
    
    func find(name: String) -> Password? {
        let table = Table(tableName)
        let query = table.filter(name == tname)
        do {
            for row in try db.prepare(query) {
                let res: Password = try row.decode()
                return res
            }
        } catch {
            FZlog.error(error)
        }
        return nil
    }
    
    func listAll() -> [Password] {
        let table = Table(tableName)
        do {
            let result: [Password] = try db.prepare(table).map { row in
                return try row.decode()
            }
            return result
        } catch {
            FZlog.error(error)
        }
        return []
    }
    
    // MARK: Private
    private func createTable() -> Void {
        do {
            let table = Table(tableName)
            try db.run(table.create(ifNotExists: true) { t in
                t.column(tid, primaryKey: .autoincrement)
                t.column(tname, unique: true)
                t.column(tdomain)
                t.column(tusername)
                t.column(tpasswrod)
                t.column(tnote)
            })
        } catch {
            FZlog.error("table create error: \(error)")
        }
    }
}

