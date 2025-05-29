//
//  CryptoListCoordinator.swift
//  TestApplication
//
//  Created by Владимир on 28.05.2025.
//

import Foundation
import UIKit

protocol CryptoListFlow: AnyObject {
    func selectCrypto(crypto: CryptoData)
    func logout()
}

protocol CryptoInfoFlow: AnyObject {
    func logout()
}

final class CryptoListCoordinator: Coordinator, CryptoListFlow, CryptoInfoFlow {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let service = CryptoService()
        let viewModel = CryptoListViewModel(cryptoService: service)
        let vc = CryptoListViewController(viewModel: viewModel)
        viewModel.output = self
        navigationController.setViewControllers([vc], animated: false)
    }
    
    func selectCrypto(crypto: CryptoData) {
        let viewModel = CryptoInfoViewModel(cryptoData: crypto)
        viewModel.output = self
        let viewController = CryptoInfoViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func logout() {
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
        }, completion: nil)
    }
}
