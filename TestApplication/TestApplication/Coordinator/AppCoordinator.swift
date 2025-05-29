//
//  AppCoordinator.swift
//  TestApplication
//
//  Created by Владимир on 25.05.2025.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        if UserDefaults.standard.isUserLoggedIn() {
            let tabBarController = TabBarAppController()
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        } else {
            let coord = LoginCoordinator(navigationController: navigationController)
            coordinate(to: coord)
        }
    }
}
