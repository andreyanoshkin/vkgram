//
//  AppService.swift
//  VKgram
//
//  Created by Andrey on 12/01/2021.
//  Copyright © 2021 Andrey. All rights reserved.
//

import Foundation
import PromiseKit

class AppsService: NetworkService {

    func getApps(appIds: String) -> Promise<AppResponse> {
        return getDataAndDecode(method: "apps.get", queryItems: [
            .init(name: "app_ids", value: "\(appIds)"),
            .init(name: "platform", value: "ios"),
        ])
    }
}
