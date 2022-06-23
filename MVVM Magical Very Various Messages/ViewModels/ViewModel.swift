//
//  ViewModel.swift
//  MVVM Magical Very Various Messages
//
//  Created by Daniel Tvorun on 23.06.2022.
//

enum Status {
    case success
    case failure
}

class ViewModel {
    public var status = Dynamic(("", .failure))
}
