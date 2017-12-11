//
//  AddUserViewModel.swift
//  User Manager
//
//  Created by Ivan Matkovic on 10/12/2017.
//  Copyright © 2017 Ivan Matkovic. All rights reserved.
//

import Foundation
class AddUserViewModel {


    enum AddUserType {
        case new
        case existing
    }

    var user: User?
    let type: AddUserType
    private let userService: UserServiceProtocol!
    var onComplete: (() -> Void)?


    init(_ userService: UserServiceProtocol) {
        self.userService = userService
        type = .new
    }


    init(_ user: User, _ userService: UserServiceProtocol) {
        self.user = user
        self.userService = userService
        type = .existing
    }

    func createUser(firstName: String, lastName: String, email: String, isAdmin: Bool) {

        let userType = isAdmin ? UserType.admin : UserType.normal

        switch type {

        case .existing:
            guard let id = user?.id else { return }
            userService.updateUser(id: id, firstName: firstName, lastName: lastName, email: email, type: userType, onComplete: {
                self.onComplete?()
            })

        case .new:
            userService.createUser(firstName: firstName, lastName: lastName, email: email, type: userType) {
                self.onComplete?()
            }
        }

    }

}
