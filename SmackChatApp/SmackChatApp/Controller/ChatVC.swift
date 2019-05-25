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
    
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                if success {
                    NotificationCenter.default.post(name: .USER_DATA_DID_CHANGE, object: nil)
                }
            }
        }
        
        MessageService.instance.findAllChannel { (success) in
            if success {
                
            }
        }
        
    }
}
