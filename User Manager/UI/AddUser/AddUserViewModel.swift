//
//  AddUserViewModel.swift
//  User Manager
//
//  Created by Ivan Matkovic on 10/12/2017.
//  Copyright © 2017 Ivan Matkovic. All rights reserved.
//

import Foundation
class AddUserViewModel {

    private let userService: UserServiceProtocol!
    var onComplete: (() -> Void)?


    init(_ userService: UserServiceProtocol) {
        self.userService = userService
    }

    func registerUser(firstName: String, lastName: String, email: String, isAdmin: Bool) {

        let userType = isAdmin ? UserType.admin : UserType.normal

        userService.createUser(firstName: firstName, lastName: lastName, email: email, type: userType) {
            self.onComplete?()
        }
    }

}
