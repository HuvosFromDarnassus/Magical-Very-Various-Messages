//
//  ChatViewController.swift
//  MVVM Magical Very Various Messages
//
//  Created by Daniel Tvorun on 22.06.2022.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet private weak var chatTableView: UITableView!
    @IBOutlet private weak var messageTextField: UITextField!
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func sendMessageButtonPressed(_ sender: UIButton) {
    }
}
