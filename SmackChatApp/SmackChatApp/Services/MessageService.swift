//
//  MessageService.swift
//  SmackChatApp
//
//  Created by AhemadAbbas Vagh on 25/05/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    var channels = [Channel]()
    var messages = [Message]()
    var unreadChannels = [String]()
    var selectedChannel: Channel?
    
    static let instance = MessageService()
    
    private init () { }
    
    func findAllChannel(completion: @escaping CompletionHandler) {
        
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                do {
                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                    NotificationCenter.default.post(name: .CHANNELS_LOADED, object: nil)
                    completion(true)
                } catch let error {
                    completion(false)
                    debugPrint(error as Any)
                }
                
//                if let json = JSON(data: data).array {
//                    for item in json {
//                        let name = item["name"].stringValue
//                        let description = item["description"].stringValue
//                        let id = item["_id"].stringValue
//                        let channel = Channel(title: name, description: description, id: id)
//                        self.channels.append(channel)
//                    }
//                    completion(true)
//                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findAllMessagesForChannel(channelId: String, completion: @escaping CompletionHandler) {
        
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                self.clearMessages()
                guard let data = response.data else { return }
                if let json = JSON(data: data).array {
                    for item in json {
                        let messageBody = item["messageBody"].stringValue
                        let id = item["_id"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let channelId = item["channelId"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        
                        let message = Message(message: messageBody, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, username: userName, timeStamp: timeStamp)
                        self.messages.append(message)
                    }
                    completion(true)
                }
                
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
        
    }
    
    func clearMessages() {
        self.messages.removeAll()
    }
    
    func clearAllChannels() {
        self.channels.removeAll()
    }
    
}
