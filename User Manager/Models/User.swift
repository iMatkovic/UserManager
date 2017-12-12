//
//  User.swift
//  User Manager
//
//  Created by Ivan Matkovic on 10/12/2017.
//  Copyright © 2017 Ivan Matkovic. All rights reserved.
//

import Foundation
enum UserType: String, Codable {
    case admin = "admin"
    case normal = "oper"
}
struct User: Codable {

    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let type: UserType

    var fullName: String {
        return "\(firstName) \(lastName)"
    }

    var isAdmin: Bool {
        return type == .admin
    }


    enum CodingKeys: String, CodingKey {
        case id = "sifra"
        case firstName = "ime"
        case lastName = "prezime"
        case email
        case type = "uloga"
    }
}
