//
//  FeedTableViewCell.swift
//  User Manager
//
//  Created by Ivan Matkovic on 10/12/2017.
//  Copyright © 2017 Ivan Matkovic. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!

    //MARK: - Data
    var user: User? {
        didSet {
            firstNameLabel.text = user?.firstName
            lastNameLabel.text = user?.lastName
            emailLabel.text = user?.email
        }
    }

    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

}
