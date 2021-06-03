//
//  App.swift
//  VKgram
//
//  Created by Andrey on 12/01/2021.
//  Copyright © 2021 Andrey. All rights reserved.
//

import Foundation


// MARK: - Response
struct AppResponse: Codable {
    let count: Int
    let items: [App]
}

// MARK: - Item
struct App: Codable {
    let type: String
    let id: Int
    let title: String
    let authorOwnerID: Int
    let icon278: String

    enum CodingKeys: String, CodingKey {
        case type, id, title
        case authorOwnerID = "author_owner_id"
        case icon278 = "icon_278"
    }
}
