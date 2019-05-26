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
            userProfileImage.image = UIImage(named: message?.userAvatar ?? "profileDefault")
            userProfileImage.backgroundColor = UserDataService.instance.returnUIColor(components: message?.userAvatarColor ?? "")
            
            guard var isoDate = message?.timeStamp else { return }
            let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
            isoDate = String(isoDate[..<end])
            
            let isoFormatter = ISO8601DateFormatter()
            let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
            
            let newFormatter = DateFormatter()
            newFormatter.dateFormat = "MMM d, hh:mm a"
            
            if let finalDate = chatDate {
                 timeStampLabel.text = newFormatter.string(from: finalDate)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
