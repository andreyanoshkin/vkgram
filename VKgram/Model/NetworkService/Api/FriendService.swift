//
//  FriendService.swift
//  VKgram
//
//  Created by Andrey on 13/12/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation
import PromiseKit

class FriendsService: NetworkService {
    
    func getFriends() -> Promise<[User]> {
        firstly {
            self.getFriendsIds()
        }.then { ids -> Promise<[User]> in
            let stringOfIds = ids.friendsIds.map {"\($0)"}.joined(separator: ",")
            return self.getUsers(ids: stringOfIds)
        }
    }
    
    private func getFriendsIds() -> Promise<FriendsIds> {
        return getDataAndDecode(method: "friends.get", queryItems: [.init(name: "count", value: "10"),])
    }
    
    func getUsers(ids: String) -> Promise<[User]> {
        return getDataAndDecode(method: "users.get", queryItems: [
            .init(name: "user_ids", value: ids),
            .init(name: "fields", value: "photo_200, verified"),
            .init(name: "name_case", value: "Nom"),
        ])
    }
}
