//
//  AppDelegate.swift
//  Photogram
//
//  Created by Velarde Robles, David on 13/03/2019.
//  Copyright © 2019 David Velarde. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        window?.backgroundColor = .white
        let homeViewController = HomeViewController()
        let navController = UINavigationController(rootViewController: homeViewController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()

        return true
    }
}
