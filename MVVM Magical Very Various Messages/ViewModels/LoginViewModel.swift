//
//  LoginViewModel.swift
//  MVVM Magical Very Various Messages
//
//  Created by Daniel Tvorun on 23.06.2022.
//

import Firebase

class LoginViewModel: ViewModel {
    public func loginUser(with email: String, _ password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
          
            if let e = error {
                strongSelf.status.value = ("\(Constants.FB.loginFailure) \(e.localizedDescription)", .failure)
                print("SIGN IN ERROR: \(e.localizedDescription)")
                
                return
            }
            
            strongSelf.status.value = (Constants.FB.registerSuccess, .success)
        }
    }
}
