//
//  FriendsInfo.swift
//  VKgram
//
//  Created by Andrey on 13/12/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation

// MARK: - Response
struct FriendsIds: Codable {
    let friendsIds: [Int]

    enum CodingKeys: String, CodingKey {
        case friendsIds = "items"
    }
}


// MARK: - ResponseElement
struct User: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let canAccessClosed: Bool?
    let isClosed: Bool?
    let photo200: String
    let verified: Int?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id = "id"
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case photo200 = "photo_200"
        case verified = "verified"
    }
}

