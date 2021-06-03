//
//  SceneDelegate.swift
//  VKgram
//
//  Created by Andrey on 12/09/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = LoginFormViewController()
        window?.makeKeyAndVisible()
    }

}

