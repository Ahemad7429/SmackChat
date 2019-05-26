//
//  UserDataService.swift
//  SmackChatApp
//
//  Created by AhemadAbbas Vagh on 23/05/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    
    private init () {
        
    }
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""

    func setUserData(id: String, avatarColor: String, avatarName: String, email: String, name: String) {
        self.id = id
        self.avatarColor = avatarColor
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
    
    func returnUIColor(components: String) -> UIColor {
        
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b, a : NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        
        guard let rUnrapped = r else { return defaultColor }
        guard let gUnrapped = g else { return defaultColor }
        guard let bUnrapped = b else { return defaultColor }
        guard let aUnrapped = a else { return defaultColor }
        
        let rFloat = CGFloat(rUnrapped.doubleValue)
        let gFloat = CGFloat(gUnrapped.doubleValue)
        let bFloat = CGFloat(bUnrapped.doubleValue)
        let aFloat = CGFloat(aUnrapped.doubleValue)
        
        return UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)

    }
    
    func logOutUser() {
        id = ""
        avatarColor = ""
        avatarName = ""
        email = ""
        name = ""
        AuthService.instance.authToken = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        MessageService.instance.clearAllChannels()
        MessageService.instance.clearMessages()
    }
}
