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
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var messageTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var userTypingStatusLabel: UILabel!
    
    var isTyping = false
    
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    //MARK: Functions
    func setUpView() {
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        
        sendButton.isHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableView.automaticDimension
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_:)), name: .USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(channelSelected(_:)), name: .CHANNELS_SELECTED, object: nil)
        
        SocketService.instance.getChatMessage { (success) in
            if success {
                self.tableView.reloadData()
                if self.tableView.numberOfRows(inSection: 0) > 0 {
                    self.tableView.scrollToRow(at: IndexPath(row: MessageService.instance.messages.count - 1, section: 0), at: .bottom, animated: true)
                }
            }
        }
        
        SocketService.instance.getTypingUsers { (typingUsers) in
            guard let channelId = MessageService.instance.selectedChannel?._id else { return }
            
            var names = ""
            var numberOfTypingUsers = 0
            
            for (typingUser, channel) in typingUsers {
                if typingUser != UserDataService.instance.name && channel == channelId {
                    if names == "" {
                        names = typingUser
                    } else {
                        names = "\(names), \(typingUser)"
                    }
                    
                    numberOfTypingUsers += 1
                }
            }
            
            if numberOfTypingUsers != 0 && AuthService.instance.isLoggedIn {
                var verb = "is"
                if numberOfTypingUsers > 1 {
                    verb = "are"
                }
                
                self.userTypingStatusLabel.text = "\(names) \(verb) typing a message ..."
                
            } else {
                self.userTypingStatusLabel.text = ""
            }
        }
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                if success {
                    NotificationCenter.default.post(name: .USER_DATA_DID_CHANGE, object: nil)
                }
            }
        }
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @objc func userDataDidChange(_ notification: Notification) {
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        } else {
            channelNameLabel.text = "Please Log In"
            tableView.reloadData()
        }
    }
    
    @objc func channelSelected(_ notification: Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.name ?? ""
        channelNameLabel.text = "#\(channelName)"
        getMessages()
    }
    
    
    func  onLoginGetMessages() {
        MessageService.instance.findAllChannel { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel =  MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.channelNameLabel.text = "No Channel Yet!"
                }
            }
        }
    }
    
    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?._id else { return }
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: Actions
    @IBAction func sendMessageButtonTapped(_ sender: Any) {
        guard let message = messageTF.text, message != "" else { return }
        guard let channelId = MessageService.instance.selectedChannel?._id, channelId != "" else { return }
        
        if AuthService.instance.isLoggedIn {
            SocketService.instance.addMessage(messageBody: message, channelId: channelId, userId: UserDataService.instance.id) { (success) in
                if success {
                    self.messageTF.text = ""
                    self.messageTF.resignFirstResponder()
                    SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
                }
            }
        }
    }
    
    
    @IBAction func editingChange(_ sender: UITextField) {
        
        guard let channelId = MessageService.instance.selectedChannel?._id else { return }
        
        if sender.text == "" {
            isTyping = false
            sendButton.isHidden = true
            SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
        } else {
            if isTyping == false {
                sendButton.isHidden = false
                SocketService.instance.socket.emit("startType", UserDataService.instance.name, channelId)
            }
            
            isTyping = true
        }
    }
}

extension ChatVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as? MessageCell else { return UITableViewCell() }
        cell.message = MessageService.instance.messages[indexPath.row]
        return cell
    }
}

