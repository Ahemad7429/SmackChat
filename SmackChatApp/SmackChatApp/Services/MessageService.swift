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
    
    func clearAllChannels() {
        self.channels.removeAll()
    }
}
