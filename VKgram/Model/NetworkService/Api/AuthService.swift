//
//  AuthService.swift
//  VKgram
//
//  Created by Andrey on 02/06/2021.
//  Copyright © 2021 Andrey. All rights reserved.
//

import PromiseKit

class AuthService: NetworkService {
    
    override var version: String { return "5.68" }
    
    func getLoginForm() -> URLRequest {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = API.scheme
        urlComponents.host = API.authHost
        urlComponents.path = API.authPath
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: API.clientID),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "+8194"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: API.version)
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        return request
        
    }
    
}

