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
    
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- Actions
    
    @IBAction func createAccntBtnTapped(_ sender: Any) {
        guard let email = emailTF.text, email != "" else {
            return
        }
        
        guard let pwd = passwordTF.text, pwd != "" else {
            return
        }
        
        AuthService.instance.registeUser(email: email, password: pwd) { (sucess) in
            if sucess {
                AuthService.instance.loginUser(email: email, password: pwd, completion: { (success) in
                    if sucess {
                        print("Login Success! ", AuthService.instance.authToken)
                    }
                })
            }
        }
    }
    
    @IBAction func pickAvatarBtnTapped(_ sender: Any) {
    }
    
    @IBAction func generateBGColorBtnTapped(_ sender: Any) {
    }
    
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
}
