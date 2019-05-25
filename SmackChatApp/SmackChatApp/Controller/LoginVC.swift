//
//  LoginVC.swift
//  SmackChatApp
//
//  Created by AhemadAbbas Vagh on 20/05/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: Functions
    func setupView() {
        spinner.isHidden = true
        userNameTF.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor : SmackPlaceHolder])
        passwordTF.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : SmackPlaceHolder])
        
    }
    
    //MARK: Actions
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccoutBtnTapped(_ sender: UIButton) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let email = userNameTF.text, email != "" else { return }
        guard let password = passwordTF.text, password != "" else { return }
        
        spinner.isHidden = false
        spinner.startAnimating()
        AuthService.instance.loginUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (sucess) in
                    if success {
                        NotificationCenter.default.post(name: .USER_DATA_DID_CHANGE, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
}
