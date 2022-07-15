//
//  LoginViewModel.swift
//  MVVM Magical Very Various Messages
//
//  Created by Daniel Tvorun on 23.06.2022.
//

import Firebase

class LoginViewModel: LoginRegisterViewModel {
    public func loginUser(with email: String, _ password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            if let e = error {
                strongSelf.setStatus(.failure, value: "\(Constants.FB.loginFailure) \(e.localizedDescription)", type: strongSelf)
                
                print("\(Constants.E.userLoginError) \(e.localizedDescription)")
                return
            }
            
            strongSelf.setStatus(.success, value: Constants.FB.registerSuccess, type: strongSelf)
        }
    }
}
