//
//  WelcomeViewController.swift
//  MVVM Magical Very Various Messages
//
//  Created by Daniel Tvorun on 22.06.2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet private weak var appNameLabel: UILabel!
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        appNameLabel.text = Constants.appName
    }
}
