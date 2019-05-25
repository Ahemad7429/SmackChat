//
//  ChatVC.swift
//  SmackChatApp
//
//  Created by AhemadAbbas Vagh on 19/05/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var channelNameLabel: UILabel!
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
         NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_:)), name: .USER_DATA_DID_CHANGE, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(channelSelected(_:)), name: .CHANNELS_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                if success {
                    NotificationCenter.default.post(name: .USER_DATA_DID_CHANGE, object: nil)
                }
            }
        }
    }
    
    @objc func userDataDidChange(_ notification: Notification) {
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
            channelNameLabel.text = "Smack"
        } else {
            channelNameLabel.text = "Please Log In"
        }
    }
    
    @objc func channelSelected(_ notification: Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.name ?? ""
        channelNameLabel.text = "#\(channelName)"
    }
    
    
    func  onLoginGetMessages() {
        MessageService.instance.findAllChannel { (success) in
            if success {
                
            }
        }
    }
}
