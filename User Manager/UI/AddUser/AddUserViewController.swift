//
//  AddUserViewController.swift
//  User Manager
//
//  Created by Ivan Matkovic on 10/12/2017.
//  Copyright © 2017 Ivan Matkovic. All rights reserved.
//

import UIKit

class AddUserViewController: UIViewController {

    @IBOutlet weak var saveUserButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var isAdminLabel: UILabel!
    @IBOutlet weak var isAdminSwitch: UISwitch!


    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {

        guard let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text,
            let email = emailTextField.text else {
                return
        }

        let isAdmin = isAdminSwitch.isOn

        viewModel?.createUser(firstName: firstName, lastName: lastName, email: email, isAdmin: isAdmin)


    }

    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss()
    }

    private func dismiss() {

        if viewModel?.type == .existing {
            navigationController?.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }

    }

    var viewModel: AddUserViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        if viewModel == nil {
            self.viewModel = AddUserViewModel(UserService())
        }

        configure()

        viewModel?.onComplete = { [weak self] in
            self?.dismiss()
        }
    }

    private func configure() {
        firstNameTextField.placeholder = "First name"
        lastNameTextField.placeholder = "Last name"
        emailTextField.placeholder = "Email"
        isAdminLabel.text = "Is user admin?"
        isAdminSwitch.isOn = false

        if let user = viewModel?.user {
            firstNameTextField.text = user.firstName
            lastNameTextField.text = user.lastName
            emailTextField.text = user.email
            //isAdminSwitch.isOn =
        }

    }

}
