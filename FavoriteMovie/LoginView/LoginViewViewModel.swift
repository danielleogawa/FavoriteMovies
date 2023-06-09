//
//  LoginViewViewModel.swift
//  FavoriteMovie
//
//  Created by Danielle Nozaki Ogawa on 2023/04/15.
//

import Foundation
import LocalAuthentication

protocol LoginViewViewModelDelegate {
    func popTohomeViewController()
}


final class LoginViewViewModel {
    var delegate: LoginViewViewModelDelegate?
    private var context = LAContext()
    
    init(delegate: LoginViewViewModelDelegate) {
        self.delegate = delegate
        context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
        state = .loggedout
    }
    
    private enum AuthenticationState {
        case loggedin, loggedout
    }
    
    private var state: AuthenticationState?
    
    func loginIn() {
        if state == .loggedin {
            print("user logged out")
            state = .loggedout
        } else {
            context = LAContext()
            context.localizedCancelTitle = "Enter Username/Password"
            var error: NSError?
            
            guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
                print(error?.localizedDescription ?? "Can't evaluate policy")
                return
            }
            
            Task {
                do {
                    try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Log in to your account")
                    state = .loggedin
                    delegate?.popTohomeViewController()
                    print("user logged in")
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            
        }
    }
}
