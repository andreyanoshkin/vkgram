//
//  NewsFeedService.swift
//  VKgram
//
//  Created by Andrey on 06/12/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import PromiseKit

class NewsFeedService: NetworkService {
    
    override var version: String { return "5.68" }
    
    func getNewsFeedItems() -> Promise<(ItemResponse, ProfileResponse, GroupResponse)> {
        
        return firstly {
            getItems()
        }.then (on: DispatchQueue.global(qos: .background)) { data in
            when(fulfilled:self.parseItem(data: data), self.parseProfile(data: data), self.parseGroup(data: data))
        }
    }
    
    func getNewsFeedItemsWithStartTime(startFrom: String) -> Promise<(ItemResponse, ProfileResponse, GroupResponse)> {
        
        return firstly {
            getItemsWithStartTime(startFrom: startFrom)
        }.then (on: DispatchQueue.global(qos: .background)) { data in
            when(fulfilled:self.parseItem(data: data), self.parseProfile(data: data), self.parseGroup(data: data))
        }
    }
    
    private func getItemsWithStartTime(startFrom: String) -> Promise<Data> {
        return self.getData(method: "newsfeed.get", queryItems: [
            .init(name: "filters", value: "post, photo"),
            .init(name: "start_from", value: "\(startFrom)")
        ])
    }
    
    private func getItems() -> Promise<Data> {
        return self.getData(method: "newsfeed.get", queryItems: [
            .init(name: "filters", value: "post, photo")
        ])
    }
    
    private func parseItem(data: Data) -> Promise<ItemResponse> {
        return self.decodeData(data: data)
    }
    
    private func parseProfile(data: Data) -> Promise<ProfileResponse> {
        return self.decodeData(data: data)
    }
    
    private func parseGroup(data: Data) -> Promise<GroupResponse> {
        return self.decodeData(data: data)
    }
}
