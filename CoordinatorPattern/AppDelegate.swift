//
//  AppDelegate.swift
//  CoordinatorPattern
//
//  Created by Bob Godwin Obi on 24.05.19.
//  Copyright © 2019 Bob Godwin Obi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /// Instantiate the main navigation controller to be used for our app
        let navController = UINavigationController()
        navController.navigationBar.isHidden = true
        //// Instantiate MainCoordinator and inject `navController`
        coordinator = MainCoordinator(navigationController: navController)
        /// coordinator start
        coordinator?.start()
        /// create UIWindow and makeKeyAndVisible
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) { }
}
