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

let BASE_URL = "https://chatslackchat.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"

// Segues

let TO_LOGIN = "toLoginVC"
let TO_CREATE_ACCOUNT = "toCreateAccountVC"
let UNWIND = "unwindToChannel"

// User Default keys

let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL_KEY = "userEmail"

