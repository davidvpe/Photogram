//
//  MainTabBar.swift
//  Photogram
//
//  Created by Velarde Robles, David on 15/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit
import Hero

class MainTabBarController: UITabBarController {
    func initialSetup() {
        let home = HomeViewController()
        home.hero.isEnabled = true
        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "picture"), selectedImage: nil)
        let album = AlbumFeedViewController()
        album.hero.isEnabled = true
        album.tabBarItem = UITabBarItem(title: "Albums", image: UIImage(named: "albums"), selectedImage: nil)
        viewControllers = [home, album].map({ vc -> UIViewController in
            let navController = UINavigationController(rootViewController: vc)
            navController.hero.isEnabled = true
            navController.tabBarItem = vc.tabBarItem
            return navController
        })
        hero.isEnabled = true
    }
}

extension UITabBarController {
    func hideTabBarAnimated(hide: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            if hide {
                self.tabBar.transform = CGAffineTransform(translationX: 0, y: self.tabBar.bounds.size.height)
            } else {
                self.tabBar.transform = .identity
            }
        })
    }
}
