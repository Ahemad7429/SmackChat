//
//  ProfileVC.swift
//  SmackChatApp
//
//  Created by AhemadAbbas Vagh on 24/05/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    // MARK: LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: Functions
    
    func setupView() {
        userNameLabel.text = UserDataService.instance.name
        userEmailLabel.text = UserDataService.instance.email
        profileImage.image = UIImage(named: UserDataService.instance.avatarName)
        profileImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandle))
        bgView.addGestureRecognizer(tap)
    }
    
    @objc func tapHandle() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Actions
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        UserDataService.instance.logOutUser()
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: .USER_DATA_DID_CHANGE, object: nil)
    }
    
}
