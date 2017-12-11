//
//  FeedDetailsViewModel.swift
//  User Manager
//
//  Created by Ivan Matkovic on 11/12/2017.
//  Copyright © 2017 Ivan Matkovic. All rights reserved.
//

import Foundation
class FeedDetailsViewModel {

    var userId: String?
    var userService: UserServiceProtocol!
    var onComplete: ((User) -> Void)?
    var user: User?
    
    init(userId: String, userService: UserServiceProtocol) {
        self.userId = userId
        self.userService = userService
    }

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
