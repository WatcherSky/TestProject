//
//  Stub.swift
//  TestApplication
//
//  Created by Владимир on 26.05.2025.
//

import Foundation
import UIKit

final class TabBarAppController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.barTintColor = UIColor(red: 55/255, green: 62/255, blue: 125/255, alpha: 0.05)
        tabBar.tintColor = UIColor(red: 38/255, green: 39/255, blue: 60/255, alpha: 1)
        tabBar.unselectedItemTintColor =  UIColor(red: 206/255, green: 208/255, blue: 222/255, alpha: 1)
        
        tabBar.isTranslucent = false
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
        
        let cryptoNav = UINavigationController()
        let cryptoCoordinator = CryptoListCoordinator(navigationController: cryptoNav)
        cryptoCoordinator.start()
        
        cryptoNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tabBarIconHome"), tag: 0)
        
        let stub1 = StubViewController()
        stub1.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tabBarIconCharts"), tag: 1)
        
        let stub2 = StubViewController()
        stub2.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tabBarIconWallet"), tag: 2)
        
        let stub3 = StubViewController()
        stub3.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tabBarIcon3"), tag: 3)
        
        let stub4 = StubViewController()
        stub4.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tabBarIconUser"), tag: 4)
        
        viewControllers = [cryptoNav, stub1, stub2, stub3, stub4]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBar.frame.size.height = 80
        tabBar.frame.origin.y = view.frame.height - 80
    }
}
