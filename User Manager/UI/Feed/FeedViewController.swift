//
//  FeedViewController.swift
//  User Manager
//
//  Created by Ivan Matkovic on 10/12/2017.
//  Copyright © 2017 Ivan Matkovic. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {


    struct Constants {
        static let searchBarFrameHeight: CGFloat = 44.0
    }


    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!


    //MARK: - Dependencies
    private var viewModel: FeedViewModel!


    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUsers()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Users"

        tableViewSetup()
        searchBarSetup()

        viewModel = FeedViewModel(userService: UserService())

        viewModel.onComplete = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    //MARK: - Utility
    fileprivate func tableViewSetup() {
        tableView.delegate = self
        tableView.dataSource = self
    }


    private func searchBarSetup() {
        searchBar.delegate = self
        tableView.contentOffset.y = searchBar.frame.height
        searchBar.placeholder = "Search users"
        searchBar.searchBarStyle = .minimal
        searchBar.showsCancelButton = true
    }

    func hideSearchBar() {
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.searchBar.text = ""
            self?.searchBar.endEditing(true)
            self?.tableView.contentOffset.y = self?.searchBar.frame.height ?? Constants.searchBarFrameHeight
        }

    }


    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "addUser" {

            guard let nc = segue.destination as? UINavigationController,
                let vc = nc.viewControllers.first as? AddUserViewController
                else { return }

            let addUserViewModel = AddUserViewModel(UserService())
            vc.viewModel = addUserViewModel
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

        let feedDetailsViewModel = FeedDetailsViewModel(userId: user.id, userService: UserService())
        viewController.viewModel = feedDetailsViewModel
        viewController.title = "Add user"

        navigationController?.pushViewController(viewController, animated: true)
    }

}

extension FeedViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let query = searchBar.text else {
            return
        }
        viewModel.searchUsers(query: query)
        searchBar.endEditing(true)
    }

    func searchBarCancelButtonClicked(_: UISearchBar) {
        hideSearchBar()
        viewModel.getUsers()
    }

}
