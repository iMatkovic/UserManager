//
//  ApiPaths.swift
//  User Manager
//
//  Created by Ivan Matkovic on 10/12/2017.
//  Copyright © 2017 Ivan Matkovic. All rights reserved.
//

import Foundation
struct ApiPaths {
    static let getUser = "http://it.ffos.hr/P11617/tjakopec/P3/Programiranje3API/read"
    static let createUser = "http://it.ffos.hr/P11617/tjakopec/P3/Programiranje3API/create"
    static let editUser = "http://it.ffos.hr/P11617/tjakopec/P3/Programiranje3API/update"
    static let deleteUser = "http://it.ffos.hr/P11617/tjakopec/P3/Programiranje3API/delete"
    static let searchUser = "http://it.ffos.hr/P11617/tjakopec/P3/Programiranje3API/search/an"

    static func getUserDetails(id: String) -> String {
        return "http://it.ffos.hr/P11617/tjakopec/P3/Programiranje3API/read/" + id
    }
}
