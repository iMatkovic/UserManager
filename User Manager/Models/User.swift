//
//  User.swift
//  User Manager
//
//  Created by Ivan Matkovic on 10/12/2017.
//  Copyright © 2017 Ivan Matkovic. All rights reserved.
//

import Foundation
enum UserType: String {
    case admin = "admin"
    case normal = "oper"
}
struct User: Codable {

    var id: String
    var firstName: String
    var lastName: String
    var email: String

    enum CodingKeys: String, CodingKey {
        case id = "sifra"
        case firstName = "ime"
        case lastName = "prezime"
        case email
    }
}
