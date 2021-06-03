//
//  GroupsService.swift
//  VKgram
//
//  Created by Andrey on 11/01/2021.
//  Copyright © 2021 Andrey. All rights reserved.
//

import Foundation

import PromiseKit

class GroupsService: NetworkService {
    
    override var version: String { return "5.76" }

    func getUserGroups(userId: Int) -> Promise<GroupsResponse> {
        return getDataAndDecode(method: "groups.get", queryItems: [
            .init(name: "user_id", value: "\(userId)"),
            .init(name: "extended", value: "1"),
        ])
    }
}
