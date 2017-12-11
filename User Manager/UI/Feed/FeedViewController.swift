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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUsers()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        self.title = "Users"

        viewModel = FeedViewModel(userService: UserService())

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

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            guard let user = viewModel.itemAt(index: indexPath.row) else {
                return
            }

            showDeleteAlert(id: user.id, fullName: user.fullName)
        }
    }


    func showDeleteAlert(id: String, fullName: String) {
        let alert = UIAlertController(title: "Delete", message: "Are you sure you want permantently delete \(fullName)", preferredStyle: .actionSheet)


        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.viewModel.deleteUser(id: id)
        }

        alert.addAction(deleteAction)
        alert.addAction(cancelAction)

        self.present(alert, animated: true)

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let user = viewModel.itemAt(index: indexPath.row) else {
            return
        }


        let storyboard = UIStoryboard(name: "Feed", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FeedDetailsViewController") as! FeedDetailsViewController

        let feedDetailsViewModel = FeedDetailsViewModel.init(userId: user.id, userService: UserService())
        viewController.viewModel = feedDetailsViewModel

        navigationController?.pushViewController(viewController, animated: true)
    }

}
