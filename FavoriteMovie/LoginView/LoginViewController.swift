//
//  LoginViewController.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/04/15.
//

import UIKit
import LocalAuthentication

final class LoginViewController: UIViewController {
    
    var screen: LoginScreen?
    var viewModel: LoginViewViewModel?
    
    override func loadView() {
        self.view = screen
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.screen = LoginScreen()
        self.viewModel = LoginViewViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        screen?.setBackground()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.setViewDelegate(delegate: self)
    }
    
}

extension LoginViewController: LoginScreenDelegate {
    func loginButtonTapped() {
        viewModel?.loginIn()
    }
}
