//
//  RegisterViewModel.swift
//  MVVM Magical Very Various Messages
//
//  Created by Daniel Tvorun on 22.06.2022.
//

import Firebase

class RegisterViewModel: LoginRegisterViewModel {
    public func registerUser(with email: String, _ password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                self.setStatus(.failure, value: "\(Constants.FB.registerFailure) \(e.localizedDescription)", type: self)
                
                print("\(Constants.E.userRegisterError) \(e.localizedDescription)")
                return
            }
            
            self.setStatus(.success, value: Constants.FB.registerSuccess, type: self)
        }
    }
}
