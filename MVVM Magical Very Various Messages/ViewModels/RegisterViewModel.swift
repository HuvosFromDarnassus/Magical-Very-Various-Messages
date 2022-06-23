//
//  RegisterViewModel.swift
//  MVVM Magical Very Various Messages
//
//  Created by Daniel Tvorun on 22.06.2022.
//

import Firebase

class RegisterViewModel: ViewModel {
    public func registerUser(with email: String, _ password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                self.status.value = ("\(Constants.FB.registerFailure) \(e.localizedDescription)", .failure)
                print("SIGN UP ERROR: \(e.localizedDescription)")
                
                return
            }

            self.status.value = (Constants.FB.registerSuccess, .success)
        }
    }
}
