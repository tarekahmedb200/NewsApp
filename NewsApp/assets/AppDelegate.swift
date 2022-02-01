//
//  AppDelegate.swift
//  NewsApp
//
//  Created by lapshop on 1/31/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var homeCoordinator : HomeCoordinator!
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = UINavigationController()
        homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

   


}

