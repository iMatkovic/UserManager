//
//  FeedDetailsViewController.swift
//  User Manager
//
//  Created by Ivan Matkovic on 11/12/2017.
//  Copyright © 2017 Ivan Matkovic. All rights reserved.
//

import UIKit

class FeedDetailsViewController: UIViewController {


    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    var viewModel: FeedDetailsViewModel!


    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getUserDetails()

        viewModel.onComplete = { [weak self] user in
            self?.firstNameLabel.text = user.firstName
            self?.lastNameLabel.text = user.lastName
            self?.emailLabel.text = user.email
        }

    }

}
