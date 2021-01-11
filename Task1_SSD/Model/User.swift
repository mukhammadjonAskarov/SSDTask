//
//  User.swift
//  Task1_SSD
//
//  Created by Mukhammadjon Askarov on 09/01/21.
//

import Foundation

class User {
    
    var name: String    = ""
    var dateCreatedAt: String = ""
    var id: Int         = 0
 
    init(name: String, dateCreatedAt: String) {
        self.name  = name
        self.dateCreatedAt   = dateCreatedAt
    }
    
}
