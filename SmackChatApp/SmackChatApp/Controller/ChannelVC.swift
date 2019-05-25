//
//  ChannelVC.swift
//  SmackChatApp
//
//  Created by AhemadAbbas Vagh on 19/05/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.width - 60.0
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_:)), name: .USER_DATA_DID_CHANGE, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpUserInfo()
    }
    
    //MARK: Functions
    @objc func userDataDidChange(_ notification: Notification) {
        setUpUserInfo()
    }
    
    func setUpUserInfo() {
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
    
    //MARK: Action
    
    @IBAction func prepareForUnwind(sender: UIStoryboardSegue) {}
    
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

extension ChannelVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCell", for: indexPath) as? ChannelCell else { return UITableViewCell() }
        cell.configureCell(channel: MessageService.instance.channels[indexPath.row])
        return cell
    }
}
