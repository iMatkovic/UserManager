//
//  FeedDetailsViewModel.swift
//  User Manager
//
//  Created by Ivan Matkovic on 11/12/2017.
//  Copyright © 2017 Ivan Matkovic. All rights reserved.
//

import Foundation
class FeedDetailsViewModel {
    //MARK: - Properties
    var userId: String?
    var onComplete: ((User) -> Void)?
    var user: User?

    //MARK: - Dependencies
    var userService: UserServiceProtocol!

    //MARK: - Inits
    init(userId: String, userService: UserServiceProtocol) {
        self.userId = userId
        self.userService = userService
    }


    //MARK: - Public methods
    func getUserDetails() {

        guard let id = userId else {
            return
        }

        userService.getUserDetails(id: id) { [weak self] user in
            self?.user = user
            self?.onComplete?(user)
        }
    }

}
