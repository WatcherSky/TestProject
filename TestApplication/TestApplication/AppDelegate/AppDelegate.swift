//
//  AppDelegate.swift
//  TestApplication
//
//  Created by Владимир on 23.05.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        guard let window = window else {
            fatalError("Window could not be created")
        }
        coordinator = AppCoordinator(window: window)
        coordinator?.start()
        
        return true
    }
}
