//
//  LoginViewController.swift
//  MVVM Magical Very Various Messages
//
//  Created by Daniel Tvorun on 22.06.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var statusLabel: UILabel!
    
    private let viewModel: LoginViewModel = LoginViewModel()
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    @IBAction private func loginButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            viewModel.loginUser(with: email, password)
        }
    }
    
    private func bindViewModel() {
        viewModel.statusText.bind { (statusText) in
            DispatchQueue.main.async {
                self.statusLabel.text = statusText
            }
        }
    }
}
