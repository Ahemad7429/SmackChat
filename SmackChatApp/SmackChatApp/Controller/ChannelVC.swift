//
//  ChannelVC.swift
//  SmackChatApp
//
//  Created by AhemadAbbas Vagh on 19/05/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userProfile: UIImageView!
    @IBAction func prepareForUnwind(sender: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.width - 60.0
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_:)), name: .USER_DATA_DID_CHANGE, object: nil)
    }
    
    @objc func userDataDidChange(_ notification: Notification) {
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userProfile.image = UIImage(named: UserDataService.instance.avatarName)
            userProfile.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            loginBtn.setTitle("Login", for: .normal)
            userProfile.image = #imageLiteral(resourceName: "menuProfileIcon.png")
            userProfile.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        
        if AuthService.instance.isLoggedIn {
            let profileVC = ProfileVC()
            profileVC.modalPresentationStyle = .custom
            present(profileVC, animated: true, completion: nil)
            
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
        
    }
}
