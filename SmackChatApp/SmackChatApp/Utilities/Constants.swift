//
//  Constants.swift
//  SmackChatApp
//
//  Created by AhemadAbbas Vagh on 20/05/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ success: Bool) -> ()

// API URLs
let BASE_URL            = "https://chatslackchat.herokuapp.com/v1/"
let URL_REGISTER        = "\(BASE_URL)account/register"
let URL_LOGIN           = "\(BASE_URL)account/login"
let URL_USER_ADD        = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL   = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS    = "\(BASE_URL)channel/"

// Colors
let SmackPlaceHolder    = #colorLiteral(red: 0.3266413212, green: 0.4215201139, blue: 0.7752227187, alpha: 0.5031513612)

// Segues
let TO_LOGIN = "toLoginVC"
let TO_CREATE_ACCOUNT = "toCreateAccountVC"
let TO_AVATAR_PICKER = "toAvatarPickerVC"
let UNWIND = "unwindToChannel"


// User Default keys
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL_KEY = "userEmail"

let HEADERS = [
    "Content-Type" : "application/json; charset=utf-8"
]

let BEARER_HEADER = [
    "Authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-Type" : "application/json; charset=utf-8"
]

extension Notification.Name {
    static let USER_DATA_DID_CHANGE = NSNotification.Name("userDataDidChange")
}
