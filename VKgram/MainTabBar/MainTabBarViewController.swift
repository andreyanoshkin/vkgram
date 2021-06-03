//
//  MainTabBarViewController.swift
//  VKgram
//
//  Created by Andrey on 20/09/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = UIColor.white
        setupBar()
        
    }
    
    
    func setupBar() {
        
        
        func configureImage(image:UIImage) -> UIImage {
            let size = CGSize(width: 24, height: 24)
            let scaledImage = image.scaleToSize(size: size)
            return scaledImage.withRenderingMode(.alwaysOriginal)
        }
        
        let settingsImage = configureImage(image: UIImage(named: "settings")!)
        let settingsFilledImage = configureImage(image: UIImage(named: "settingsFilled")!)
        let userImage = configureImage(image: UIImage(named: "user")!)
        let userFilledImage = configureImage(image: UIImage(named: "userFilled")!)
        let usersImage = configureImage(image: UIImage(named: "users")!)
        let usersFilledImage = configureImage(image: UIImage(named: "usersFilled")!)
        let homeImage = configureImage(image: UIImage(named: "home")!)
        let homeFilledImage = configureImage(image: UIImage(named: "homeFilled")!)
        
        
        let userFriendsViewController = createNavigationController(vc: UserFriendsTableViewController(), selected: userFilledImage, unselected: userImage)
        let userGroupsViewController = createNavigationController(vc: UserGroupsViewController(), selected: usersFilledImage, unselected: usersImage)
        let newsFeedViewController = createNavigationController(vc: NewsFeedViewController(), selected: homeFilledImage, unselected: homeImage)
        let settingsViewController = createNavigationController(vc: SettingsViewController(), selected: settingsFilledImage, unselected: settingsImage)
        
        viewControllers = [newsFeedViewController, userFriendsViewController, userGroupsViewController, settingsViewController]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0) // TODO: to put in constants
        }
    }
}

extension UITabBarController {
    func createNavigationController(vc: UIViewController, selected: UIImage, unselected: UIImage) -> UINavigationController {
        let viewController = vc
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.image = unselected
        navigationController.tabBarItem.selectedImage = selected
        return navigationController
    }
}
