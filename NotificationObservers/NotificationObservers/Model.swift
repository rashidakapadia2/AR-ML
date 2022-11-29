//
//  Model.swift
//  NotificationObservers
//
//  Created by Apple on 21/11/22.
//

import Foundation

enum Localization: String {
    case name = "name1"
    
    var lamg: String {
            return NSLocalizedString(self.rawValue, comment: "Rashida")
    }
}

struct User {
    let id: Int?
    let name: String?
    let address: String?
}

let user1 = User(id: 1, name: Localization.name.lamg, address: NSLocalizedString("address1", comment: "asdfgh"))
let user2 = User(id: 2, name: NSLocalizedString("name2", comment: "Rashida"), address: NSLocalizedString("address2", comment: "asdfgh"))
let user3 = User(id: 3, name: NSLocalizedString("name3", comment: "Rashida"), address: NSLocalizedString("address3", comment: "asdfgh"))

let userArr = [user1, user2, user3]
