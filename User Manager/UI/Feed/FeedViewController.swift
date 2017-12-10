//
//  FeedViewController.swift
//  User Manager
//
//  Created by Ivan Matkovic on 10/12/2017.
//  Copyright © 2017 Ivan Matkovic. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var viewModel: FeedViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        self.title = "Users"

        viewModel = FeedViewModel(userService: UserService())
        viewModel.getUsers()

        viewModel.onComplete = { [weak self] in
            self?.tableView.reloadData()
        }
    }

}
//MARK: - Extensions

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell

        if let user = viewModel.itemAt(index: indexPath.row) {
            cell.user = user
        }

        return cell
    }

}
