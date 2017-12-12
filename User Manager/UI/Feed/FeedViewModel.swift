//
//  FeedViewModel.swift
//  User Manager
//
//  Created by Ivan Matkovic on 10/12/2017.
//  Copyright © 2017 Ivan Matkovic. All rights reserved.
//

import Foundation
class FeedViewModel {

    //MARK: - Dependencies
    private let userService: UserServiceProtocol!


    //MARK: - Properties
    var onComplete: (() -> Void)?
    var users: [User] = []


    //MARK: - init
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }

    //MARK: - Public methods
    func getUsers() {
        userService.getAllUsers { [weak self] usersResult in
            self?.users = self?.filter(usersResult) ?? []
            self?.onComplete?()
        }
    }

    func userCount() -> Int {
        return users.count
    }

    func itemAt(index: Int) -> User? {
        return index < users.count || index > users.count - 1 ? users[index] : nil
    }

    func deleteUser(id: String) {
        userService.deleteUser(id: id) { [weak self] in
            self?.getUsers()
        }
    }

    //MARK: - Private methods
    private func filter(_ users: [User]) -> [User] {
        return users.filter { !$0.firstName.isEmpty }
    }

}
