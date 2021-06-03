//
//  NetworkService.swift
//  VKgram
//
//  Created by Andrey on 04/12/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation
import PromiseKit

class NetworkService {
    
    let baseHost: String = "api.vk.com"
    var version: String { return "5.124" }
    let configuration = URLSessionConfiguration.default
    
    func getData(method: String, queryItems: [URLQueryItem] = []) -> Promise<Data> {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = self.baseHost
        urlConstructor.path = "/method/\(method)"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: ApiManager.session.userId),
            URLQueryItem(name: "access_token", value: ApiManager.session.token),
            URLQueryItem(name: "v", value: version),
        ]
        
        urlConstructor.queryItems?.append(contentsOf: queryItems)
        
        let request = URLRequest(url: urlConstructor.url!)
        let session = URLSession(configuration: configuration)
        
        return Promise<Data> { seal in
            let task = session.dataTask(with: request) { (data, response, apiError) in
                
                if let error = apiError {
                    seal.reject(error)
                }
                
                if let data = data {
                    seal.fulfill(data)
                }
            }
            task.resume()
        }
    }
    
    func decodeData<Output: Codable>(data: Data) -> Promise<Output> {
        
        let decoder = JSONDecoder()
        
        return Promise { seal in
            
            do {
                let response = try decoder.decode(VKResponse<Output>.self, from: data)
                seal.fulfill(response.data)
            } catch let decodingError {
                ApiManager.session.eraseAll()
                debugPrint(decodingError)
                seal.reject(decodingError)
            }
            
        }
    }
    
    func getDataAndDecode<Output: Codable>(method: String, queryItems: [URLQueryItem] = []) -> Promise<Output> {
        firstly {
            getData(method: method, queryItems: queryItems)
        }.then { (data: Data) in
            self.decodeData(data: data)
        }
    }
}
