//
//  AddChannelVC.swift
//  SmackChatApp
//
//  Created by AhemadAbbas Vagh on 25/05/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var channelNameTF: UITextField!
    @IBOutlet weak var channelDescriptionTF: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: Functions
    func setupView() {
        channelNameTF.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedString.Key.foregroundColor : SmackPlaceHolder])
        channelDescriptionTF.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedString.Key.foregroundColor : SmackPlaceHolder])
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(touchHandle))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func touchHandle() {
        self.view.endEditing(true)
    }

    //MARK: Actions
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChannelButtonTapped(_ sender: Any) {
        guard let name = channelNameTF.text, name != "" else { return }
        guard let description = channelDescriptionTF.text, description != "" else { return }
        
        SocketService.instance.addChannel(channelName: name, channelDescription: description) { (success) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
