//
//  AuthService.swift
//  SmackChatApp
//
//  Created by AhemadAbbas Vagh on 22/05/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import Foundation
import Alamofire

class AuthService {
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            return defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            return defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL_KEY) as! String
        }
        set {
            return defaults.set(newValue, forKey: USER_EMAIL_KEY)
        }
    }
    
    private init() {
        
    }
    
    func registeUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerEmail = email.lowercased()
        
        let headers = [
            "Content-Type" : "application/json; charset=utf-8"
        ]
        
        let body = [
            "email": lowerEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseString { (response) in
            
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
}
