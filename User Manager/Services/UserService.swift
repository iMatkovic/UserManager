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
    func createUser(firstName: String, lastName: String, email: String, type: UserType, onComplete: @escaping (() -> Void))
    func deleteUser(id: String, onComplete: @escaping (() -> Void))
    func getUserDetails(id: String, onComplete: @escaping (User) -> ())
    func updateUser(id: String, firstName: String, lastName: String, email: String, type: UserType, onComplete: @escaping (() -> Void))

}

class UserService: UserServiceProtocol {

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

    func createUser(firstName: String, lastName: String, email: String, type: UserType, onComplete: @escaping (() -> Void)) {

        let params = ["ime": firstName,
            "prezime": lastName,
            "email": email,
            "uloga": type.rawValue]

        Alamofire.request(ApiPaths.createUser, method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseData { response in
                switch response.result {
                case .success:
                    onComplete()
                case .failure(let error):
                    print(error)
                }
        }
    }

    func deleteUser(id: String, onComplete: @escaping (() -> Void)) {

        let params = ["sifra": id]

        Alamofire.request(ApiPaths.deleteUser, method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseData { response in
                switch response.result {
                case .success:
                    onComplete()
                case .failure(let error):
                    print(error)
                }
        }
    }

    func getUserDetails(id: String, onComplete: @escaping (User) -> ()) {
        Alamofire.request(ApiPaths.getUserDetails(id: id)).responseData { response in
            switch response.result {
            case .success(let user):
                let decoded = try! JSONDecoder().decode(User.self, from: user)
                onComplete(decoded)
            case .failure:
                print("Something wrong happened")
            }
        }
    }

    func updateUser(id: String, firstName: String, lastName: String, email: String, type: UserType, onComplete: @escaping (() -> Void)) {

        let params = ["sifra": id,
            "ime": firstName,
            "prezime": lastName,
            "email": email,
            "uloga": type.rawValue]

        Alamofire.request(ApiPaths.editUser, method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseData { response in
                switch response.result {
                case .success:
                    onComplete()
                case .failure(let error):
                    print(error)
                }
        }
    }



}

