//
//  VKResponse.swift
//  VKgram
//
//  Created by Andrey on 04/12/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation

struct VKResponse<T: Codable>: Codable {
    let data: T
    
    enum CodingKeys: String, CodingKey {
        case data = "response"
    }
}


// MARK: - Response
struct ApiErrorWrapped: Codable {
    let error: ApiError

    enum CodingKeys: String, CodingKey {
        case error = "error"
    }
}

// MARK: - Error
struct ApiError: Codable {
    let errorCode: Int
    let errorMsg: String
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMsg = "error_msg"
    }
}

enum VKError: Error, LocalizedError {
    case unknown
    
    var errorDescription: String? {
        return "turn on VPN"
    }
}

