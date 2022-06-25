//
//  MessageTableViewCell.swift
//  MVVM Magical Very Various Messages
//
//  Created by Daniel Tvorun on 23.06.2022.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet public weak var messageBubble: UIView!
    @IBOutlet public weak var messageText: UILabel!
    @IBOutlet public weak var rightImageView: UIImageView!
    @IBOutlet public weak var leftImageView: UIImageView!
    
    internal override func awakeFromNib() {
        super.awakeFromNib()
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }

    internal override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
