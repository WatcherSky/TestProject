//
//  File.swift
//  TestApplication
//
//  Created by Владимир on 26.05.2025.
//

import UIKit

protocol LoginFlow: AnyObject {
    func login()
}

final class LoginCoordinator: Coordinator, LoginFlow {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = LoginViewModel()
        viewModel.output = self
        let vc = LoginViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func login() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let tabBar = TabBarAppController()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: [.transitionFlipFromRight],
                          animations: {
            window.rootViewController = tabBar
        })
    }
    
    func onLogout() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        let loginNavController = UINavigationController()
        
        let loginCoordinator = LoginCoordinator(navigationController: loginNavController)
        loginCoordinator.start()
        
        UIView.transition(with: window,
                          duration: 0.3,
                          options: [.transitionCrossDissolve],
                          animations: {
            window.rootViewController = loginNavController
            window.makeKeyAndVisible()
        },
                          completion: nil)
    }
}
