//
//  CreateAccountVC.swift
//  SmackChatApp
//
//  Created by AhemadAbbas Vagh on 20/05/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    
    // MARK:- Outlets
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var profileIMG: UIImageView!
    
    let avatarColor = "[0.5,0.5,0.5,1]"
    var avatarName = "profileDefault"
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            profileIMG.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
        }
    }
    
    //MARK:- Actions
    
    @IBAction func createAccntBtnTapped(_ sender: Any) {
        guard let email = emailTF.text, email != "" else {
            return
        }
        guard let pwd = passwordTF.text, pwd != "" else {
            return
        }
        guard let userName = userNameTF.text, userName != "" else {
            return
        }
        
        AuthService.instance.registeUser(email: email, password: pwd) { (sucess) in
            if sucess {
                AuthService.instance.loginUser(email: email, password: pwd, completion: { (success) in
                    if sucess {
                        AuthService.instance.createUser(name: userName, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if sucess {
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func pickAvatarBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func generateBGColorBtnTapped(_ sender: Any) {
    }
    
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
}
