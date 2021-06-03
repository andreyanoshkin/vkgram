//
//  APIManager.swift
//  VKgram
//
//  Created by Andrey on 04/12/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class ApiManager {
    static let session = ApiManager()
    
    var token: String {
        get {
            KeychainWrapper.standard.string(forKey: "vk-api-token") ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: "vk-api-token")
        }
    }
    var userId: String {
        get {
            KeychainWrapper.standard.string(forKey: "vk-api-user-id") ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: "vk-api-user-id")
        }
    }
    
    func eraseAll() {
        KeychainWrapper.standard.removeAllKeys()
    }
    
    private init() {}
    
}
