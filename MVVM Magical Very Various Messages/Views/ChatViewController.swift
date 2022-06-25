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
    
    private let viewModel: ChatViewModel = ChatViewModel()
    
    private var messages: [Message] = []
    
    public var didUserSignedUp: Bool? {
        didSet {
            viewModel.prepareMessage(by: Constants.welcomeMessage)
        }
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.dataSource = self
        chatTableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        bindViewModel()
        
        viewModel.loadMessages()
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
        setupViewController()
    }
    
    @IBAction private func sendMessageButtonPressed(_ sender: UIButton) {
        guard let messageBody = messageTextField.text, !messageBody.isEmpty else {
            messageTextField.placeholder = "Type something"
            return
        }
        
        viewModel.prepareMessage(by: messageBody)
        
        messageTextField.text = ""
        messageTextField.placeholder = "Message text"
    }
    
    @IBAction private func logoutButtonPressed(_ sender: UIBarButtonItem) {
        viewModel.logoutUser()
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func bindViewModel() {
        viewModel.status.bind { (_, messages, status) in
            if status == .success {
                if let unwrappedMessages = messages as? [Message] {
                    self.messages = unwrappedMessages
                }
                
                self.setupTableView(by: self.messages.count)
            }
        }
    }
    
    private func setupViewController() {
        title = Constants.appName
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.tintColor = UIColor(named: Constants.Styles.blue)
    }
    
    private func setupTableView(by messageCount: Int) {
        if self.messages.isEmpty {
            return
        }
        
        self.chatTableView.reloadData()
        let indexPath = IndexPath(row: messageCount == 0 ? 0 : messageCount - 1, section: 0)
        self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageTableViewCell
        
        cell.messageText.text = message.body
        
        if viewModel.checkMessageSender(by: message.sender) {
            cell.rightImageView.isHidden = false
            cell.leftImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: Constants.Styles.blue)
            cell.messageText.textColor = UIColor(named: Constants.Styles.lightYellow)
        } else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: Constants.Styles.lightYellow)
            cell.messageText.textColor = UIColor(named: Constants.Styles.blue)
        }
        
        return cell
    }
}
