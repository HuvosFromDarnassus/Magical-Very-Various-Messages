//
//  LoginRegisterViewModel.swift
//  MVVM Magical Very Various Messages
//
//  Created by Daniel Tvorun on 15.07.2022.
//

enum Status {
    case success
    case failure
}

class LoginRegisterViewModel {
    public var status: Dynamic<Status> = Dynamic(.failure)
    public var statusText: Dynamic = Dynamic("")
    
    internal func setStatus(_ status: Status, value: String, type: LoginRegisterViewModel) {
        type.status.value = status
        type.statusText.value = value
    }
}
