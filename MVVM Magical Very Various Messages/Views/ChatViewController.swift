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
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        bindViewModel()
        viewModel.loadMessages()
    }
    
    @IBAction private func sendMessageButtonPressed(_ sender: UIButton) {
        guard let messageBody = messageTextField.text, !messageBody.isEmpty else {
            messageTextField.placeholder = "Type something"
            return
        }
        viewModel.prepareMessage(by: messageBody)
        resetTextField()
    }
    
    @IBAction private func logoutButtonPressed(_ sender: UIBarButtonItem) {
        viewModel.logoutUser()
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func resetTextField() {
        messageTextField.text = ""
        messageTextField.placeholder = "Message text"
    }
    
    private func setupTableDataSource() {
        chatTableView.dataSource = self
        chatTableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    private func setupNavigationController() {
        title = Constants.appName
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.tintColor = UIColor(named: Constants.Styles.blue)
    }
    
    private func setupViewController() {
        setupTableDataSource()
        setupNavigationController()
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

// MARK: - ViewModelBindable
extension ChatViewController: ViewModelBindable {
    internal func bindViewModel() {
        viewModel.messages.bind { (messages) in
            self.messages = messages
            
            DispatchQueue.main.async {
                self.setupTableView(by: messages.count)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageTableViewCell
        
        if !messages.isEmpty {
            let message = messages[indexPath.row]
            cell.messageText.text = message.body
            
            setupMessageBox(by: message.sender, using: cell)
        }
        
        return cell
    }
    
    private func setupMessageBox(by sender: String, using cell: MessageTableViewCell) {
        if viewModel.checkMessageSender(by: sender) {
            setupCurrentUserMessageBox(using: cell)
        } else {
            setupOtherUserMessageBox(using: cell)
        }
    }
    
    private func changeMessageColors(_ bubbleColor: String, _ textColor: String, for cell: MessageTableViewCell) {
        cell.messageBubble.backgroundColor = UIColor(named: bubbleColor)
        cell.messageText.textColor = UIColor(named: textColor)
    }
    
    private func setupCurrentUserMessageBox(using cell: MessageTableViewCell) {
        cell.rightImageView.isHidden = false
        cell.leftImageView.isHidden = true
        changeMessageColors(Constants.Styles.blue, Constants.Styles.lightYellow, for: cell)
    }
    
    private func setupOtherUserMessageBox(using cell: MessageTableViewCell) {
        cell.leftImageView.isHidden = false
        cell.rightImageView.isHidden = true
        changeMessageColors(Constants.Styles.lightYellow, Constants.Styles.blue, for: cell)
    }
}
