//
//  Constants.swift
//  MVVM Magical Very Various Messages
//
//  Created by Daniel Tvorun on 22.06.2022.
//

struct Constants {
    static let appName = "🪄MVVM"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    static let cellNibName = "MessageTableViewCell"
    static let cellIdentifier = "ReusableCell"
    static let welcomeMessage = "Welcome to MVVM 👋, write something cool 🤙."
    
    struct Styles {
        static let blue = "backgroundBlue"
        static let yellow = "contrastYellow"
        static let lightYellow = "lightYellow"
        static let success = "successGreen"
        static let failure = "dangerRed"
    }
    
    struct FB {
        static let registerSuccess = "You successfully signed up"
        static let registerFailure = "Sign up failed:"
        static let loginSuccess = "You successfully signed in"
        static let loginFailure = "Sign in failed:"
        
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
