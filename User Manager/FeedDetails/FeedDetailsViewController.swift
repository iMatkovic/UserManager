//
//  FeedDetailsViewController.swift
//  User Manager
//
//  Created by Ivan Matkovic on 11/12/2017.
//  Copyright © 2017 Ivan Matkovic. All rights reserved.
//

import UIKit

class FeedDetailsViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    //MARK: - Dependencies
    var viewModel: FeedDetailsViewModel!


    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getUserDetails()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.onComplete = { [weak self] user in
            self?.firstNameLabel.text = user.firstName
            self?.lastNameLabel.text = user.lastName
            self?.emailLabel.text = user.email
        }
    }

    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "editUser" {
            print(segue.destination)
            guard let user = viewModel.user, let nc = segue.destination as? UINavigationController,
                let vc = nc.viewControllers.first as? AddUserViewController else { return }

            let addUserViewModel = AddUserViewModel(user, UserService())
            vc.viewModel = addUserViewModel
        }
    }
}
