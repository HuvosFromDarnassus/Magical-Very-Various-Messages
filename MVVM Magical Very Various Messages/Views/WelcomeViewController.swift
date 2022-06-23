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
        animateLabel()
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = UIColor(named: Constants.Styles.yellow)
    }
    
    private func animateLabel() {
        var charIndex = 0.0
        for letter in Constants.appName {
            Timer.scheduledTimer(withTimeInterval: 0.2 * charIndex, repeats: false) { (timer) in
                self.appNameLabel.text?.append(letter)
            }
            
            charIndex += 1
        }
    }
}
