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
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.width - 60.0
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_:)), name: .USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(channelsLoaded(_:)), name: .CHANNELS_LOADED, object: nil)
        
        SocketService.instance.getChannel { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpUserInfo()
    }
    
    //MARK: Functions
    @objc func userDataDidChange(_ notification: Notification) {
        setUpUserInfo()
    }
    
    @objc func channelsLoaded(_ notification: Notification) {
        tableView.reloadData()
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
            tableView.reloadData()
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
    
    @IBAction func addChannelButtonTapped(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let addChannelVC = AddChannelVC()
            addChannelVC.modalPresentationStyle = .custom
            self.present(addChannelVC, animated: true, completion: nil)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        NotificationCenter.default.post(name: .CHANNELS_SELECTED, object: nil)
        self.revealViewController()?.revealToggle(animated: true)
    }
}
