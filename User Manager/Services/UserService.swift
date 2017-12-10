//
//  UserService.swift
//  User Manager
//
//  Created by Ivan Matkovic on 10/12/2017.
//  Copyright © 2017 Ivan Matkovic. All rights reserved.
//

import Foundation
import Alamofire
protocol UserServiceProtocol {
    func getAllUsers(onComplete: @escaping ([User]) -> ())
}

class UserService: UserServiceProtocol {


    func get() {

    }

    func getAllUsers(onComplete: @escaping ([User]) -> ()) {
        Alamofire.request(ApiPaths.getUser).responseData { response in
            switch response.result {
            case .success(let data):
                let decoded = try! JSONDecoder().decode([User].self, from: data)
                onComplete(decoded)
            case .failure:
                print("Something wrong happened")
            }
        }

    }
}

