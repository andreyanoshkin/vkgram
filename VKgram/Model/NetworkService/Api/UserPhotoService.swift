//
//  UserPhotoService.swift
//  VKgram
//
//  Created by Andrey on 11/01/2021.
//  Copyright © 2021 Andrey. All rights reserved.
//

import Foundation
import PromiseKit

class UserPhotoService: NetworkService {
    
    override var version: String { return "5.76" }

    func getPhotos(userId: Int) -> Promise<PhotoResponse> {
        return getDataAndDecode(method: "photos.get", queryItems: [
            .init(name: "owner_id", value: "\(userId)"),
            .init(name: "album_id", value: "wall"),
            .init(name: "extended", value: "1"),
            .init(name: "count", value: "50"),
        ])
    }
}
