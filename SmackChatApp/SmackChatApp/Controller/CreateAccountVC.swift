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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var avatarColor = "[0.5,0.5,0.5,1]"
    var avatarName = "profileDefault"
    var avatarBGColor: UIColor?
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            profileIMG.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            
            if avatarName.contains("light") && avatarBGColor == nil {
                profileIMG.backgroundColor = .lightGray
            }
        }
    }
    
    //MARK:- Functions
    func setupView() {
        spinner.isHidden = true
        userNameTF.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor : SmackPlaceHolder])
        emailTF.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor : SmackPlaceHolder])
        passwordTF.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : SmackPlaceHolder])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
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
        
        spinner.isHidden = false
        spinner.startAnimating()
        
        AuthService.instance.registeUser(email: email, password: pwd) { (sucess) in
            if sucess {
                AuthService.instance.loginUser(email: email, password: pwd, completion: { (success) in
                    if sucess {
                        AuthService.instance.createUser(name: userName, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if sucess {
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                
                                NotificationCenter.default.post(name: .USER_DATA_DID_CHANGE, object: nil)
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
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        avatarBGColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        avatarColor = "[\(r),\(g),\(b),1]"
        UIView.animate(withDuration: 0.2) {
            self.profileIMG.backgroundColor = self.avatarBGColor
        }
    }
    
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
}
