//
//  MessageCell.swift
//  SmackChatApp
//
//  Created by AhemadAbbas Vagh on 26/05/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    
    var message: Message? {
        didSet {
            messageLabel.text = message?.message
            userNameLabel.text = message?.username
            timeStampLabel.text = message?.timeStamp
            userProfileImage.image = UIImage(named: message?.userAvatar ?? "profileDefault")
            userProfileImage.backgroundColor = UserDataService.instance.returnUIColor(components: message?.userAvatarColor ?? "")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
